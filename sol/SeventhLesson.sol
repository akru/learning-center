import './Lesson.sol';
import '../market/Market.sol';
import '../market/DAOMarketRegulator.sol';

contract SeventhLesson is Lesson {
    function SeventhLesson(address _emissionRegulator)
             Lesson(_emissionRegulator)
    {}
	
    function execute(address _market, address _regulator) {
		if (accountOf[msg.sender]) throw;
		Market market = Market(_market);
		DAOMarketRegulator regulator = DAOMarketRegulator(_regulator);
		if (market.regulatorEnabled() == true && market.owner() == _regulator && regulator.market() == market) {
			emissionRegulator.deal(msg.sender, 100);
			accountOf[msg.sender] = true;
		}
    }
}