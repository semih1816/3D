// ============================================================================
// Project: Breadboard Base Plate with Cutouts (OpenSCAD)
// Author: Semih Agcaer
// License: Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
// 
// You are free to:
//   - Share — copy and redistribute the material in any medium or format
//   - Adapt — remix, transform, and build upon the material
//
// Under the following terms:
//   • Attribution — You must give appropriate credit.
//   • ShareAlike — If you remix, transform, or build upon the material,
//                  you must distribute your contributions under the same license.
//
// Full license text:
// https://creativecommons.org/licenses/by-sa/4.0/
// ============================================================================
//
// -----------------------------------------------------------------------------
// Parametric base plate with four rectangular cutouts
// Designed for breadboard mounting
// All dimensions in millimeters
// -----------------------------------------------------------------------------

// --- Main body dimensions ---
c = 0;                      // two cutouts: 'c = 0' and four cutouts 'c = 1' 
main_x =(c==0) ? 62.5 : (62.5 + 22 + 22);   // Total width (breadboard width + two 22 mm sides)

main_y = 88;               // Total length
main_z = 6;                // Total thickness

// --- Cutout dimensions ---
cut_width  = 27;           // Short dimension of each cutout (aligned with 'main_x')
cut_length = 82.7;         // Long dimension of each cutout (aligned with 'main_y')
cut_height = 5.7;          // Depth of cutouts (leaving 'main_z - cut_height' bottom thickness)
gap = main_z - 2.5;        // Gap between left/right cutouts 

bottom_thickness = main_z - cut_height; //Bottom thickness of cutouts 

difference() {

    // MAIN BODY (centered)
    cube([main_x, main_y, main_z], center = true);
       
    // MAIN PAIR OF CUTOUTS (equal size, left & right)
    // Offset in x direction: 'cut_width/2' plus half of 'gap'.
    // The body spans from '-main_z/2' to '+main_z/2' in Z direction.
    cut_center_z = -main_z/2 + cut_height/2 + bottom_thickness;  
    // Left cutout
    translate([-(cut_width/2 + gap/2), 0, cut_center_z])
        cube([cut_width, cut_length, cut_height], center = true);

    // Right cutout
    translate([+(cut_width/2 + gap/2), 0, cut_center_z])
        cube([cut_width, cut_length, cut_height], center = true);

    // SECONDARY PAIR OF NARROWER CUTOUTS
    // These appear (if 'c = 1') shifted farther outward and slightly narrower ('cut_width' - 9mm)

    // Right-side narrow cutout. power supply part is 9mm width -> 'cut_width - 9' 
    translate([+cut_width/2 + gap/2 + 11, 0, 0])
        translate([+(cut_width/2 + gap/2), 0, cut_center_z])
            cube([cut_width - 9, cut_length, cut_height], center = true);

    // Left-side narrow cutout. power supply part is 9mm width -> 'cut_width - 9' 
    translate([-cut_width/2 - gap/2 - 11, 0, 0])
        translate([-(cut_width/2 + gap/2), 0, cut_center_z])
            cube([cut_width - 9, cut_length, cut_height], center = true);

}
