-- chunkname: @IQIGame\\Module\\Common\\CardGameModule.lua

CardGameModule = {}

function CardGameModule.StartCardGameInMaze(command)
	UIModule.Open(Constant.UIControllerName.CardGameUI, Constant.UILayer.UI, {
		inMaze = true,
		cardCid = command.CardCid
	})
end

function CardGameModule.StartCardGameInMainCity(cardCid)
	DialogModule.Pause()
	UIModule.Open(Constant.UIControllerName.CardGameUI, Constant.UILayer.UI, {
		inMaze = false,
		cardCid = cardCid
	})
end

function CardGameModule.SendChooseCard(cardCfgIndex, inMaze)
	if inMaze then
		MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_CHOOSE_CARD, {
			CardCfgIndex = cardCfgIndex
		})
	else
		net_miniGame.chooseCard(cardCfgIndex)
	end
end
