import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_x/bloc/common_bloc.dart';
import 'package:space_x/bloc/common_state.dart';

class PlanetSideViewWidget extends StatelessWidget {
  const PlanetSideViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final bloc = context.read<CommonBloc>();
    return BlocBuilder<CommonBloc, CommonState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () => bloc.showOrganizationDialog(context),
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  bloc.spaceOrganization[state.selectedOrg],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    letterSpacing:
                        bloc.spaceOrganization[state.selectedOrg].length < 6
                            ? 15.0
                            : null,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.yellow,
              width: 1.8,
              height: size.width * 1.2,
            ),
          ],
        );
      },
    );
  }
}
