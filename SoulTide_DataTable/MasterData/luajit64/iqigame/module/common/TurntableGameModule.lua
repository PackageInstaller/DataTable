-- chunkname: @IQIGame\\Module\\Common\\TurntableGameModule.lua

TurntableGameModule = {}

function TurntableGameModule.StartGameInMaze(command)
	UIModule.Open(Constant.UIControllerName.TurntableGameUI, Constant.UILayer.UI, {
		inMaze = true,
		turntableCid = command.TurnTableCid
	})
end

function TurntableGameModule.StartGameInMainCity(turntableCid)
	UIModule.Open(Constant.UIControllerName.TurntableGameUI, Constant.UILayer.UI, {
		inMaze = false,
		turntableCid = turntableCid
	})
end

function TurntableGameModule.SendChooseCard(cardCfgIndex, inMaze)
	if inMaze then
		MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_TURNTABLE_RESULT, {
			CardCfgIndex = cardCfgIndex
		})
	else
		net_miniGame.turntableEnd(cardCfgIndex)
	end
end
