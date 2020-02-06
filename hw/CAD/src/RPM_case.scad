
use<TFlogo.scad>

case_brim = 0.82;  // limec okolo PCB
case_wall = 0.41*3;

pcb_l = 37.5 + 0.4;
pcb_w = 19.0 + 0.4;
pcb_t = 1.6;

M3_screw_diameter = 3.3;
M3_screw_head_height = 3;
M3_nut_diameter = 6;

module rpm_case_top(){

    difference(){
        union(){
            hull(){
                translate([0,0, -M3_screw_head_height])
                    minkowski(){
                       cube([pcb_l, pcb_w, 1]);
                       cylinder(d=2*case_wall+2*case_brim, h = M3_screw_head_height-1, $fn=50);
                    }
                
                translate([0, 0, -M3_screw_head_height - 0.8])
                    minkowski(){
                       cube([pcb_l, pcb_w, 1]);
                       cylinder(d=2*case_brim, h = 2-1, $fn=50);
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
        translate([21.59, pcb_w/2, -0.8+0.2])
            cylinder(d = M3_screw_diameter, h = 10, $fn = 50);
        translate([21.59, pcb_w/2, -0.8-10])
            cylinder(d = M3_nut_diameter, h = 10, $fn = 50);
        
        // Otvor pro LED
        translate([21.5, 16.9, -M3_screw_head_height-0.8+0.4])
            cylinder(d = 2, h = 20, $fn = 50);
        
        // Vyrez pro hrebinek
        translate([27.3, 9.525,0])
            cube([3, 10, 2*2], center=true);
        
        
        translate([21.5, 16.9, -M3_screw_head_height-.8-.1])
        difference(){
            cylinder(d = 3, h = 0.5, $fn = 50);
            cylinder(d = 3-.6, h = 0.5, $fn = 50);
        }
        
        
        translate([pcb_l-32, pcb_w/2, -M3_screw_head_height-.8-.1])
            mirror([1, 1, 0])
                linear_extrude(0.5) text("TFRPM", valign = "center", halign = "center", size=4);
        
        translate([pcb_l-28, pcb_w/2, -M3_screw_head_height-.8-.1])
            mirror([1, 1, 0])
                linear_extrude(0.4) text("01B", valign = "center", halign = "center", size=2);
        
       // translate([pcb_l-2, pcb_w/2, -M3_screw_head_height-.8-.1])
       //     mirror([1, 1, 0])
       //         linear_extrude(0.5) text("ThunderFly", valign = "center", halign = "center", size=2.8);
        translate([pcb_l-7, pcb_w/2, -M3_screw_head_height-.8-.1])
            mirror([1, 1, 0])
              scale([0.15, 0.15, 1])
                TF_logo(0.5);

        
        
       /* 
        translate([2, pcb_w/4, -M3_screw_head_height-.8-.1])
            mirror([1, 1, 0])
                linear_extrude(0.3) text("I2C", valign = "center", halign = "center", size=3);
        translate([2, pcb_w/4*3, -M3_screw_head_height-.8-.1])
            mirror([1, 1, 0])
                linear_extrude(0.3) text("I2C", valign = "center", halign = "center", size=3);
        translate([pcb_l-2, pcb_w/2, -M3_screw_head_height-.8-.1])
            mirror([1, 1, 0])
                linear_extrude(0.3) text("S + -", valign = "center", halign = "center", size=3);
         */
  
        translate([-2.1, pcb_w/4, -1.5])
        rotate([0, 90, 0])
            mirror([-1, 1, 0])
                linear_extrude(0.3) text("I2C", valign = "center", halign = "center", size=2.6);
        translate([-2.1, pcb_w/4*3, -1.5])
        rotate([0, 90, 0])
            mirror([-1, 1, 0])
                linear_extrude(0.3) text("I2C", valign = "center", halign = "center", size=2.6);
        translate([pcb_l+2.1, pcb_w/2, -M3_screw_head_height/2+.1])
        rotate([0, -90, 0])
            mirror([1, 1, 0])
                linear_extrude(0.4) text("s + -", valign = "center", halign = "center", size=3.4);
               
    }

}



module rpm_case_bottom(){
    difference(){
        union(){
            hull(){
                translate([0,0, -M3_screw_head_height-3])
                    minkowski(){
                       cube([pcb_l, pcb_w, 1+3]);
                       cylinder(d=2*case_wall+2*case_brim, h = M3_screw_head_height-1+pcb_t, $fn=50);
                    }
                
                translate([0, 0, -M3_screw_head_height - 0.8-3])
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
        // Otvor pro PCB
        difference(){
            translate([0, 0, -4])
                cube([pcb_l, pcb_w, 10]);
            translate([21.59, pcb_w/2, -10])
                cylinder(d = M3_nut_diameter+2, h = 10, $fn = 50);
            translate([31, 0, -5])
                cube([pcb_l, pcb_w, 6]);
        }
        // Vyrez pro hrebinek
        translate([27.3+10, pcb_w/2,-1.55])
            cube([20, 8, 3.2], center=true);
        
        // Vyrez pro autopiloti konektory
        translate([-6, 0, -4.35-0.15])
            cube([12, 8.8, 4.35+0.15]);
        translate([-6, pcb_w-8.8, -4.35-0.15])
            cube([12, 8.8, 4.35+0.15]);
        
        
         translate([21.59, 9.522, -2]){
              translate([0, 0, 0.3])
                cylinder(d = M3_screw_diameter, h = 10, $fn = 50);
              translate([0, 0, -10])
                cylinder(d = M3_nut_diameter, h = 10, $fn = 6);
             
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

//translate([21.59, pcb_w/2, -0.8+0.2])  cylinder(d = M3_screw_diameter, h = 100, $fn = 50, center = true);

// translate([0, -30, 0])  color([0.1, 0.1, 0.1, 0.5]) translate([0, 0, 0]) cube([pcb_l, pcb_w, pcb_t]);