
use<TFlogo.scad>

include<../parameters.scad>
use<lib/stdlib/bolts.scad>

module rpm_case_top(){

    difference(){
        union(){
            hull(){
                translate([0,0, -M3_screw_head_height-1])
                    minkowski(){
                       cube([pcb_l, pcb_w, 2]);
                       cylinder(d= 2*case_wall + 2*case_brim, h = M3_screw_head_height-1, $fn=50);
                    }

                translate([0, 0, -M3_screw_head_height - 6*layer_thickness-1])
                    minkowski(){
                       cube([pcb_l, pcb_w, 1]);
                       cylinder( d=2*case_brim , h = 2-1, $fn=50);
                    }
            }

            translate([0, 0, 0])
                    minkowski(){
                       cube([pcb_l, pcb_w, 0.5]);
                       cylinder(d=2*case_brim, h = pcb_t-0.5, $fn=50);
                    }
        }

        // Otvor pro PCB
        translate([0, 0, 0])
            cube([pcb_l, pcb_w, 10]);

        // Otvory pro sroubek
        translate([21.79, pcb_w/2, - M3_screw_head_height - 7*layer_thickness -5])
            rotate(30) cylinder(d = M3_nut_diameter, h = M3_screw_head_height+0.5+5, $fn = 6);
        translate([21.79, pcb_w/2, - 6*layer_thickness+0.5])
            cylinder(d = M3_screw_diameter, h = 10, $fn = 50);

        // LED hole
        translate([21.5, 16.9, -5.5])
            cylinder(d1 = 3, d2 = 4, h = 6, $fn = 50);

        // pinheader hole
        translate([27.3, 9.525,0])
            cube([4, 12, 2.5*2], center=true);

    }
}



module rpm_case_bottom(){
    difference(){
        union(){
            hull(){
                translate([0,0, -M3_screw_head_height-3])
                    minkowski(){
                       cube([pcb_l, pcb_w, 1+3]);
                       cylinder(d=2*case_wall + 2*case_brim, h = M3_screw_head_height-1+pcb_t, $fn=50);
                    }

                translate([0, 0, -M3_screw_head_height -  6*layer_thickness - 3])
                    minkowski(){
                       cube([pcb_l, pcb_w, 1]);
                       cylinder(d=2*case_brim, h = 2-1, $fn=50);
                    }
            }


        }

        minkowski(){
           cube([pcb_l, pcb_w, 1]);
           cylinder(d=2*case_brim+2*0.15, h = pcb_t-0.5+0.1, $fn=50);
        }
        // sensor PCB
        difference(){
            translate([0, 0, -3.5])
                cube([pcb_l, pcb_w, 10]);
            translate([21.79, pcb_w/2, -10])
                cylinder(d1 = M3_nut_diameter*1.5, d2 = 6.2, h = 10-0.75, $fn = 50);
            translate([31, 0, -5])
                cube([pcb_l, pcb_w, 6]);
        }
        // Pinheader
        translate([27.3+10, pcb_w/2,-1.55])
            cube([20, 8, 3.2], center=true);

        // Vyrezy pro tisk
        /* translate([27.3+5, 2,-1.55])
            cube([10, 5, 5.2], center=true);
        translate([27.3+5, pcb_w-2,-1.55])
            cube([10, 5, 5.2], center=true);
        translate([13, pcb_w/2,-1.55])
            cube([8, pcb_w+1, 5.2], center=true); */


        // I2C connectors
        translate([-6, 0.1, -4.35 - 0.15])
            cube([12, 9, 4.35 + 0.3]);
        translate([-6, pcb_w - 9.1, -4.35 - 0.15])
            cube([12, 9, 4.35 + 0.3]);

        // screw
        translate([21.79, pcb_w/2, -2+0.3]){
            translate([0, 0,  -M3_screw_head_height -  6*layer_thickness -3 + 2 - layer_thickness]){
              translate([0, 0, M3_screw_head_height])
                cylinder(d = M3_screw_diameter, h = 10, $fn = 50);
              translate([0, 0, -10]) cylinder(d = M3_nut_diameter, h = M3_nut_height + layer_thickness+10, $fn = 50);
              translate([0, 0, -0]) cylinder(d1 = M3_nut_diameter+1, d2 = M3_nut_diameter, h = 0.5, $fn = 50);
            }

         }
    }
}

if(1){
    rpm_case_top();

    translate([0, -30, 2])
        rpm_case_bottom();
}

if(0){
    rpm_case_top();

    translate([0, pcb_w, pcb_t+0.1])
        rotate([180, 0, 0])
            rpm_case_bottom();
}

use <../../../doc/sticker/sticker_outline.scad>

translate([19, -32.8, -5.25]) color("green") %poly_rect1948(0.1);
translate([19, 22.2, -5.25]) %poly_rect1944(0.1);
