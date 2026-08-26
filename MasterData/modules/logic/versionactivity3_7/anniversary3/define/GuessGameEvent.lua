-- chunkname: @modules/logic/versionactivity3_7/anniversary3/define/GuessGameEvent.lua

module("modules.logic.versionactivity3_7.anniversary3.define.GuessGameEvent", package.seeall)

local GuessGameEvent = _M

GuessGameEvent.OnGetInfo = GameUtil.getUniqueTb()
GuessGameEvent.OnFinishGame = GameUtil.getUniqueTb()
GuessGameEvent.OnReceiveAcceptReward = GameUtil.getUniqueTb()
GuessGameEvent.OnFinishGameBackToMain = GameUtil.getUniqueTb()
GuessGameEvent.OnShowStartFinished = GameUtil.getUniqueTb()
GuessGameEvent.OnDistributeBoxFinished = GameUtil.getUniqueTb()
GuessGameEvent.OnRoundTipsShowFinished = GameUtil.getUniqueTb()
GuessGameEvent.OnRoundGuessFinished = GameUtil.getUniqueTb()
GuessGameEvent.OnGameFinished = GameUtil.getUniqueTb()
GuessGameEvent.OnRoundSelectBtnFinished = GameUtil.getUniqueTb()
GuessGameEvent.OnSearchGiftSelected = GameUtil.getUniqueTb()
GuessGameEvent.OnRoundResultShowFinished = GameUtil.getUniqueTb()
GuessGameEvent.OnRefreshTaskTipScore = GameUtil.getUniqueTb()
GuessGameEvent.OnRefreshTaskTipUnlockChanged = GameUtil.getUniqueTb()
GuessGameEvent.OnDistributeGifts = GameUtil.getUniqueTb()
GuessGameEvent.OnStartNpcSelectingGifts = GameUtil.getUniqueTb()
GuessGameEvent.OnShowNpcSelectGifts = GameUtil.getUniqueTb()
GuessGameEvent.OnHideNpcUnselectGifts = GameUtil.getUniqueTb()
GuessGameEvent.OnSelectNpcRandomGift = GameUtil.getUniqueTb()

return GuessGameEvent
