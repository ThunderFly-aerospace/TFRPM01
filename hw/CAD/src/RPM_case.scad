
include<../parameters.scad>
use<lib/stdlib/bolts.scad>

module rpm_case_top(){

    difference(){
        union(){
            hull(){
                translate([0,0, -M3_screw_head_height])
                    minkowski(){
                       cube([pcb_l, pcb_w, 2]);
                       cylinder(d= 2*case_wall + 2*case_brim, h = M3_screw_head_height-2, $fn=50);
                    }

                translate([0, 0, -M3_screw_head_height - 6*layer_thickness])
                    minkowski(){
                       cube([pcb_l, pcb_w, 1]);
                       cylinder( d=2*case_brim , h = 2-1, $fn=50);
                    }
            }
            minkowski(){
               cube([pcb_l, pcb_w, 0.5]);
               cylinder(d=2*case_brim + global_clearance/7, h = pcb_t-0.5, $fn=50); // global_clearance/7 improve fit of case top and bottom.
            }
        }

        // Otvor pro PCB
        translate([0, 0, 0])
            cube([pcb_l, pcb_w, 10]);

        // Otvory pro sroubek
        #translate([21.79, pcb_w/2, - M3_screw_head_height - 8*layer_thickness - 5])
            rotate(30) cylinder(d = M3_nut_diameter, h = M3_screw_head_height+5, $fn = 6);
        translate([21.79, pcb_w/2, - M3_screw_head_height - 7*layer_thickness])
            rotate(30) cylinder(d1 = M3_nut_diameter +1, d2 = M3_nut_diameter, h = 0.5, $fn = 6);
        translate([21.79, pcb_w/2, - 7*layer_thickness])
            cylinder(d = M3_screw_diameter, h = 10, $fn = 50);

        // LED hole
        translate([21.5, 16.9, -4.5])
            cylinder(d1 = 2.7, d2 = 4, h = 5, $fn = 50);
        translate([21.5, 16.9, -4.5])
            cylinder(d1 = 2.7+0.8, d2 = 2.7, h = 0.6, $fn = 50);

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

        translate([0, 0, -layer_thickness])
          minkowski(){
             cube([pcb_l, pcb_w, 1]);
             cylinder(d=2*case_brim+2*0.15, h = pcb_t, $fn=50);
          }
        // sensor PCB
        difference(){
            translate([0, 0, -3.5])
                cube([pcb_l, pcb_w, 10]);
            translate([21.79, pcb_w/2, -10])
                cylinder(d1 = M3_nut_diameter*1.5, d2 = 6.2, h = 10 - layer_thickness, $fn = 50);
            translate([33, 0, -5])
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
        translate([21.79, pcb_w/2, -2 + 0.15]){
            translate([0, 0,  -M3_screw_head_height -  6*layer_thickness -3 + 2 - layer_thickness]){
                translate([0, 0, M3_screw_head_height]) cylinder(d = M3_screw_diameter, h = 10, $fn = 50); // screw hole
                translate([0, 0, 0]) cylinder(d = M3_nut_diameter, h = M3_screw_head_height - layer_thickness, $fn = 50); // screw head hole
                translate([0, 0, 0]) cylinder(d1 = M3_nut_diameter+1, d2 = M3_nut_diameter, h = 0.6, $fn = 50); // hole bevel
            }

         }
    }
}

if(1){
    rpm_case_top();

    translate([0, -30, 3])
        rpm_case_bottom();
}

if(0){
    rpm_case_top();

    translate([0, pcb_w, pcb_t+0.1])
        rotate([180, 0, 0])
            rpm_case_bottom();
}

use <../../../doc/sticker/sticker_outline.scad>

translate([19, -32.8, -5.25]) color("green", 0.5) %poly_rect1948(0.1);
translate([19, 22.2, -5.25]) color("green", 0.5) %poly_rect1944(0.1);
