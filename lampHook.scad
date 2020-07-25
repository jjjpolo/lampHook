/*
*
* Name: lampHook
* -----
* Description:  This is a hook to get a lamp attached to the ceiling 
*               with a rope that lets you adjust the height that best
*               works for you. 
                You need to stick it with double sided tape. 
* -----
* Author: Jose Juan Jaramillo Polo
* -----
* Date: July 25th 2020
* -----
* Notes:    -This design is parametrizable to make it customizable and
*            adaptable to any size of lamp.
*           
*           -Look at this pictures to get a better understanding of
*            which kind of lamps can be use with this design.
*             https://www.google.com/search?q=tube+led+lamps&tbm=isch&ved=2ahUKEwjAxqTY9ufqAhUS0awKHbv9CxIQ2-cCegQIABAA&oq=tube+led+lamps&gs_lcp=CgNpbWcQAzIGCAAQCBAeULgUWLgUYO4VaABwAHgAgAFiiAFikgEBMZgBAKABAaoBC2d3cy13aXotaW1nwAEB&sclient=img&ei=huUbX8DrJJKiswW7-6-QAQ&bih=635&biw=1360&rlz=1C1GCEA_enUS899US899
*/

//---------Base dimentions
base_thick =  5;
base_length = 30;
//---------Ring dimensions
ring_thick =                5;   //ring thick
external_ring_radius=       5;   //internal ring radius
internal_ring_radius =      2; //internal ring radius
ring_grip = 2 *(external_ring_radius - internal_ring_radius);  
                                /*ring_grip is a grip among base and ring (Z axis offset)
                                This is the difference among external and internal diameter 
                                (that's the reason why I multiply it times 2)
                                */
//ring_grip=   1.5; //you can also apply a fixed ring_grip


/*
 * Function:  draw_base 
 * --------------------
 * Draws the base of the lampHook
 * The base in designed out of 4 cylindrical columns 
 * which over I applied a hull function
 * 
 */
 module draw_base()
 {
    edge_r = 3; // the radius of the columns that shape the base
    //These are the translations (coordinates) for each cylinder (column)
    base_edges_vector =
    [
        [(1*(base_length/2)) - (edge_r), (1*(base_length/2)) - (edge_r), 0],
        [(1*(base_length/2)) - (edge_r), (-1*(base_length/2)) + (edge_r), 0],
        [(-1*(base_length/2)) + (edge_r), (1*(base_length/2)) - (edge_r), 0],
        [(-1*(base_length/2)) + (edge_r), (-1*(base_length/2)) + (edge_r), 0]
    ];

    hull()
    {
        for (vector = base_edges_vector)
        {
            translate(vector) 
            {
                cylinder(h=base_thick, r1=edge_r, r2=edge_r, center=true);
            }
        }
    }     
}


/*
 * Function:  draw_ring 
 * --------------------
 * Draws the ring of the lampHook
 * The ring is based on two rotated cylinders
 * Then I perfom a difference amog two rings
 * 
 */
module draw_ring()
{
    difference()
    {
        //external ring
        translate([0,0,(1.5*base_thick)+(external_ring_radius/2)- ring_grip])
        {
            rotate(90,[0,1,0])
            {
               cylinder(h=ring_thick, r1=external_ring_radius, r2=external_ring_radius, center=true);
            }
        }

        //internal ring
        translate([0,0,(1.5*base_thick)+(external_ring_radius/2) - ring_grip])
        {
            rotate(90,[0,1,0])
            {
                cylinder(h=ring_thick, r1=internal_ring_radius, r2=internal_ring_radius, center=true);
            }
        }
    }
}


if (external_ring_radius>internal_ring_radius)
{
    draw_base();
    draw_ring();
    echo("[INFO].......Done!");
}
else
{
    echo("[ERROR].......Rings radius are not valid");
}
