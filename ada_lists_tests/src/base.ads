--
-- User types, the hierarchy to be passed upon lists.
-- Has to be in a package for OOP/inheritance/dispatching to work..
-- 
-- Copyright (C) 2019  George Shapovalov <gshapovalov@gmail.com>
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--

with Ada.Containers.Vectors;

package Base is

    type Element_Type is new Integer;
        
    type    Index_Base is new Natural;
    subtype Index      is Index_Base range 1 .. Index_base'Last;

    type Element_Array is array(Index range <>) of Element_Type;
    
    type Base_Interface is interface;
    procedure print (BI : Base_Interface) is abstract;
    procedure caller(BC : Base_Interface'Class);
    -- calls print internally to test redispatching

    ---------------------------------------
    --  specific types implementing the interface
    --
    --  first the "fixed" (more reminiscent of bounded) type
    
    type Base_Fixed(N : Index) is new Base_Interface with record
        elements : Element_Array(1 .. N);
    end record;
    
    overriding procedure print(BF : Base_Fixed);
    function "=" (Left, Right : Base_Fixed) return Boolean;

    -- For out fixed list we also need definite type
    -- the easiest way to achieve here is to set fixed size for this demo
    type Base_Fixed5 is new Base_Fixed(5) with null record;
    function set_idx_fixed(e : Index) return Base_Fixed5;
    -- a basic demo setter/constructor - sets all entries to value of index

    --------------------------------------
    -- a variant using ACV.Vectors
    package ACV is new Ada.Containers.Vectors(Index, Element_Type);

    type Base_Dynamic is new Base_Interface with record
        vec : ACV.Vector;
    end record;
    --    
    overriding procedure print(BD : Base_Dynamic);
    function set_idx_dynamic(e : Index) return Base_Dynamic;

    
    type Base_Vector is new ACV.Vector and Base_Interface with null record;
    --
    overriding procedure print(BV : Base_Vector);
    function set_idx_vector(e : Index) return Base_Vector;
    
end Base;
