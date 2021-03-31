$fa = 1;
$fs = 0.2;

// Cap type
cap_type = "Atari130XE"; // [KailhBox, Atari130XE]

// Stem type
stem_type = "KailhBoxPink"; // [KailhBoxPink]

module nil() {}

box_width = 6.45;
box_height = 4.7;
box_inner_width = 6;
box_inner_corner_radius = 2;
box_cross_x_thickness = 1.3;
box_cross_y_thickness = 1.1;
box_cross_width = 4;
box_bottom_thickness = 0.7;
box_bottom_outer_offset = 0.05;

module kailh_box() {
  union() {
    difference() {
      cube([box_width, box_width, box_height], center = true);
      minkowski() {
        cube([
          box_inner_width - box_inner_corner_radius * 2,
          box_inner_width - box_inner_corner_radius * 2,
          box_height + 0.1], center = true);
        cylinder(r = box_inner_corner_radius);
      }
    };
    cube([box_cross_width, box_cross_x_thickness, box_height], center = true);
    cube([box_cross_y_thickness, box_cross_width, box_height], center = true);
    translate([0, 0, (box_bottom_thickness - box_height) / 2])
      cube([box_width + box_bottom_outer_offset * 2, box_width + box_bottom_outer_offset * 2, box_bottom_thickness], center = true);
  }
}

atari_box_width = 6.45;
atari_box_height = 4.7;
atari_square_width = 3.05;
atari_square_depth = 2.8;
atari_box_bottom_thickness = 0.7;
atari_box_bottom_outer_offset = 0.05;

module atari130xe_box() {
  union() {
    difference() {
      cube([atari_box_width, atari_box_width, atari_box_height], center = true);
      cube([atari_square_width, atari_square_width, atari_box_height + 0.1], center = true);
      translate([0, 0, (atari_square_depth - 1) / 2])
        cylinder(r = atari_square_width * sqrt(2) / 2, h = atari_box_height - atari_square_depth + 0.1);
    }
    translate([0, 0, (atari_box_bottom_thickness - atari_box_height) / 2])
      cube([atari_box_width + atari_box_bottom_outer_offset * 2, atari_box_width + atari_box_bottom_outer_offset * 2, atari_box_bottom_thickness], center = true);
  }
}

kailh_stem_spring_column_height = 5.6;
kailh_stem_spring_column_bottom_diameter = 1.5;
kailh_stem_spring_column_upper_diameter = 1;
kailh_stem_spring_column_top_height = 0.3;
kailh_stem_spring_column_cone_height = 1.5;
kailh_stem_spring_column_offset = -0.5; // TODO: measure that
kailh_stem_main_height = 5;
kailh_stem_main_width = box_width;
kailh_stem_main_depth = 4; // TODO: measure that
kailh_stem_main_extension_depth = 1;
kailh_stem_main_extension_width = 2.2;
kailh_stem_main_hole_diameter = 3; // TODO: measure that
kailh_stem_main_hole_width = 5;
kailh_stem_main_hole_depth = 2.5; // TODO: measure that
kailh_stem_main_hole_corner_radius = 0.5;
kailh_stem_rails_thickness = 0.6;


kailh_stem_height = kailh_stem_spring_column_height;

module kailh_stem() {
  union() {
    // Main part
    translate([0, 0, kailh_stem_spring_column_height - kailh_stem_main_height])
      difference() {
        linear_extrude(height = kailh_stem_main_height, center = true) {
          polygon(points = [
            [-kailh_stem_main_width / 2, -box_width / 2],
            [kailh_stem_main_width / 2, -box_width / 2],
            [kailh_stem_main_width / 2, kailh_stem_main_depth - box_width / 2],
            [kailh_stem_main_extension_width / 2 + kailh_stem_main_extension_depth, kailh_stem_main_depth - box_width / 2],
            [kailh_stem_main_extension_width / 2, kailh_stem_main_depth - box_width / 2 + kailh_stem_main_extension_depth],
            [-kailh_stem_main_extension_width / 2, kailh_stem_main_depth - box_width / 2 + kailh_stem_main_extension_depth],
            [-kailh_stem_main_extension_width / 2 - kailh_stem_main_extension_depth, kailh_stem_main_depth - box_width / 2],
            [-kailh_stem_main_width / 2, kailh_stem_main_depth - box_width / 2],
          ]);
        }
        translate([0, kailh_stem_spring_column_offset, 0])
          union() {
            cylinder(r = kailh_stem_main_hole_diameter / 2, h = kailh_stem_main_height + 1, center = true);
            hull() {
              translate([kailh_stem_main_hole_corner_radius - kailh_stem_main_hole_width / 2, -kailh_stem_main_hole_corner_radius, 0])
                cylinder(r = kailh_stem_main_hole_corner_radius, h = kailh_stem_main_height + 1, center = true);
              translate([kailh_stem_main_hole_width / 2 - kailh_stem_main_hole_corner_radius, -kailh_stem_main_hole_corner_radius, 0])
                cylinder(r = kailh_stem_main_hole_corner_radius, h = kailh_stem_main_height + 1, center = true);
              translate([kailh_stem_main_hole_corner_radius - kailh_stem_main_hole_width / 2, kailh_stem_main_hole_corner_radius - kailh_stem_main_hole_depth, 0])
                cylinder(r = kailh_stem_main_hole_corner_radius, h = kailh_stem_main_height + 1, center = true);
              translate([kailh_stem_main_hole_width / 2 - kailh_stem_main_hole_corner_radius, kailh_stem_main_hole_corner_radius - kailh_stem_main_hole_depth, 0])
                cylinder(r = kailh_stem_main_hole_corner_radius, h = kailh_stem_main_height + 1, center = true);
            }
          }
      }
    // Spring cone
    translate([0, kailh_stem_spring_column_offset, kailh_stem_spring_column_height / 2])
      rotate([180, 0, 0])
        rotate_extrude()
          polygon(points = [
            [0, 0],
            [kailh_stem_spring_column_bottom_diameter / 2, 0],
            [kailh_stem_spring_column_bottom_diameter / 2, kailh_stem_spring_column_height - kailh_stem_spring_column_cone_height - kailh_stem_spring_column_top_height],
            [kailh_stem_spring_column_upper_diameter / 2, kailh_stem_spring_column_height - kailh_stem_spring_column_top_height],
            [kailh_stem_spring_column_upper_diameter / 2, kailh_stem_spring_column_height],
            [0, kailh_stem_spring_column_height]
          ]);
  }
}

union() {
  if (cap_type == "KailhBox") {
    translate([0, 0, box_height / 2])
      kailh_box();
  }
  if (cap_type == "Atari130XE") {
    translate([0, 0, atari_box_height / 2])
      atari130xe_box();
  }
  if (stem_type == "KailhBoxPink") {
    translate([0, 0, -kailh_stem_height / 2])
      kailh_stem();
  }
}