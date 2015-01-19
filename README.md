# CDGradientBackground
Gradient background view component for iOS.

Allows configuring
- startColour
- endColour
- starting edge (left, top, right, bottom)
- radial or linear

Use as you wish


Sample usage

  CDGradientBackground *sideGradientLeft = [[CDGradientBackground alloc] initWithFrame:CGRectMake(-5, 0, 5, self.view.bounds.size.height)];
  sideGradientLeft.startColour = [UIColor colorWithWhite:0 alpha:1.];
  sideGradientLeft.endColour = [UIColor colorWithWhite:0 alpha:0];
  sideGradientLeft.startEdge = CDGradientEdgeRight;
  [self.view addSubview:sideGradientLeft];
