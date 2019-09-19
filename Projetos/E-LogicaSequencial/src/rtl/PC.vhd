-- Elementos de Sistemas
-- developed by Luciano Soares
-- file: PC.vhd
-- date: 4/4/2017

-- Contador de 16bits
-- if (reset[t] == 1) out[t+1] = 0
-- else if (load[t] == 1)  out[t+1] = in[t]
-- else if (inc[t] == 1) out[t+1] = out[t] + 1
-- else out[t+1] = out[t]

library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    port(
        clock     : in  STD_LOGIC;
        increment : in  STD_LOGIC;
        load      : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        input     : in  STD_LOGIC_VECTOR(15 downto 0);
        output    : out STD_LOGIC_VECTOR(15 downto 0)
    );
end entity;

architecture arch of PC is
  -- Aqui declaramos sinais (fios auxiliares)
  -- e componentes (outros módulos) que serao
  -- utilizados nesse modulo.
  component Inc16 is
    port (
      a: in STD_LOGIC_VECTOR (15 downto 0);
      q: out STD_LOGIC_VECTOR(15 downto 0)
    );
  end component ;

   component MUX16 is
    port (
      a: in STD_LOGIC_VECTOR (15 downto 0);
      b: in STD_LOGIC_VECTOR(15 downto 0);
      sel: in  STD_LOGIC;
      q:  out STD_LOGIC_VECTOR(15 downto 0)
    );

  end component ;

component Register8 is
  port(
    clock:   in STD_LOGIC;
    input:   in STD_LOGIC_VECTOR(7 downto 0);
    load:    in STD_LOGIC;
    output: out STD_LOGIC_VECTOR(7 downto 0)
  );

  end component;

signal saida1, saidaInc, mux01, mux02, mux03  : STD_LOGIC_VECTOR(15 downto 0);

begin

  Incrementador: Inc16 port map(saida1, saidaInc);
  mux1: MUX16 port map(saida1, saidaInc, increment, mux01);
  mux2: MUX16 port map(mux01, input, load, mux02);
  mux3: MUX16 port map(mux02, "0000000000000000", reset, mux03);
  register18: Register8 port map(clock, mux03(7 downto 0), load, saida1(7 downto 0));  


end architecture;



