import 'package:cthulhu_solo_investigator_app/core/models/myths_counter.model.dart';

List<MythsCounter> mythsCounterList = [
  MythsCounter(
    event: 'Inquietante', 
    counter: 1, 
    sanityLoss: '0/1 - 1d2 - 1d3'
  ),
  MythsCounter(
    event: 'Miedo', 
    counter: 2, 
    sanityLoss: '0/1d4 - 1d4+1'
  ),
  MythsCounter(
    event: 'Terrorífico', 
    counter: 5, 
    sanityLoss: '1/1d6 - 1d6+1'
  ),
  MythsCounter(
    event: 'Petrificante', 
    counter: 10, 
    sanityLoss: '2/1d8 - 1d10'
  ),
  MythsCounter(
    event: 'Disociación', 
    counter: 15, 
    sanityLoss: '1d10/1d10'
  )
];