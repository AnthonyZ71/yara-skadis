
PART = "full"; // ["bracket", "washer", "print"]

module board() {
    translate([-5, 0, 0])
        rotate([90, 0, 90]) {
            import("Skadis_36x56.stl");
            translate([0, 0, 5])
                rotate([0, 270, 0])
                    import("Skadis_36x56.stl");
        }
}

module skadis_right_angle_joiner() {
    difference() {
        cube([30, 5, 25]);
        translate([20, -13.7, 12.5])
            rotate([-90, 0, 0])
                m3_16_bolt();
    }
    difference() {
        cube([5, 30, 25]);
        translate([-13.7, 20, 12.5])
            rotate([0, 90, 0])
              m3_16_bolt();
    }
    translate([0, 0, 0])
    linear_extrude(25)
        polygon([[4, 4], [10, 4], [4, 10], [4, 4]]);
}

module skadis_right_angle_washer() {
    difference() {
        cylinder(h=5, d=19.5, $fn=6);
            translate([0, 0, 5-2.39]) {
                rotate([0, 0, 30])
                    m3_nut();
                cylinder(h=20, d=3.2, center=true, $fn=36);
            }
   }
}

module m3_16_bolt() {
    cylinder(h=15.75, d=3.1, $fn=36);
        translate([0, 0, 15.74]) {
            cylinder(h=3.1, d=5.5, $fn=72);
        }
    }

module m3_nut() {
    difference() {
        cylinder(h=2.4, d=6.2, $fn=6);
        cylinder(h = 5, d=3.1, center=true, $fn=36);
    }
}

if (PART == "bracket") {
    skadis_right_angle_joiner();
} else if (PART == "washer") {
    skadis_right_angle_washer();
} else if (PART == "print") {
    skadis_right_angle_joiner();
    translate([20, 20, 0])
        skadis_right_angle_washer();
    translate([20, 40, 0])
        skadis_right_angle_washer();
} else {
    translate([0, 0, 40 - 7.5 - 5]) {
        skadis_right_angle_joiner();
    }

    translate([20, -10 , 40])
        rotate([-90, 0, 0])
            skadis_right_angle_washer();
    translate([-5, 20 , 40])
        rotate([90, 0, -90])
            skadis_right_angle_washer();

    color("white") board();
}
