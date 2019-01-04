--
--  A barebones indexed interface which can be iterated over.
-- Child packages will either pass through to core (fixed) array or a Vector;
-- test if we can create an interface and pass containers or fixed array to it later..
-- Copyright (C) 2018  <copyright holder> <email>
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- test if we can create an interface and pass containers or fixed array to it later..

with Ada.Containers.Vectors;

generic
package Lists.dynamic is

    package ACV is new Ada.Containers.Vectors(Index_Type, Element_Type);
    
    type List is new ACV.Vector and List_Interface with private;

    overriding
    function List_Constant_Reference (Container : aliased in List; Position  : Cursor) return Constant_Reference_Type;
 
    overriding
    function List_Constant_Reference (Container : aliased in List; Index : Index_Type) return Constant_Reference_Type;
 
    overriding
    function List_Reference (Container : aliased in out List; Position  : Cursor) return Reference_Type;

    overriding
    function List_Reference (Container : aliased in out List; Index : Index_Type) return Reference_Type;

    overriding
    function Iterate (Container : in List) return List_Iterator_Interfaces.Reversible_Iterator'Class;

private

    type List is new ACV.Vector and List_Interface with null record;
    
end Lists.dynamic;