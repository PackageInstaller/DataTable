-- chunkname: @modules/logic/versionactivity2_2/lopera/view/LoperaLevelTipsView.lua

module("modules.logic.versionactivity2_2.lopera.view.LoperaLevelTipsView", package.seeall)

local LoperaLevelTipsView = class("LoperaLevelTipsView", BaseView)
local mapCfgIdx = LoperaEnum.MapCfgIdx
local loperaActId = VersionActivity2_2Enum.ActivityId.Lopera
local tipsDuration = 3

function LoperaLevelTipsView:onInitView()
	self._text = gohelper.findChildText(self.viewGO, "Bg/#text")
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function LoperaLevelTipsView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_min_day_night)
	self.addEventCb(self, LoperaController.instance, LoperaEvent.EpisodeFinish, self._onGetToDestination, self)
	self.addEventCb(self, LoperaController.instance, LoperaEvent.EpisodeMove, self._onMoveInEpisode, self)
	self.addEventCb(self, LoperaController.instance, LoperaEvent.ExitGame, self.onExitGame, self)

	local params = self.viewParam
	local isBeginningTips = params.isBeginning

	self._isFinishTips = params.isFinished

	local isEndLess = params.isEndLess
	local mapId = params.mapId

	if isEndLess then
		local episodeId = Activity168Model.instance:getCurEpisodeId()
		local contentCfg = Activity168Config.instance:getConstCfg(loperaActId, episodeId)

		self._text.text = contentCfg.value2

		self:_delayClose()
	elseif isBeginningTips or self._isFinishTips then
		local contentCfg = Activity168Config.instance:getConstValueCfg(loperaActId, mapId)
		local contentArray = string.split(contentCfg.value2, "|")

		self._text.text = contentArray[isBeginningTips and 1 or 2]

		self:_delayClose()
	else
		local curCellId = params.cellIdx - 1
		local endCellData = Activity168Config.instance:getMapEndCell()
		local curCellData = Activity168Config.instance:getMapCell(curCellId)
		local curCoord = curCellData[mapCfgIdx.coord]
		local endCellCoord = endCellData[mapCfgIdx.coord]
		local distance = math.abs(curCoord[1] - endCellCoord[1]) + math.abs(curCoord[2] - endCellCoord[2])
		local distanceCfgStr = Activity168Config.instance:getConstCfg(loperaActId, 1).mlValue
		local distanceParamArr = string.split(distanceCfgStr, "|")
		local distanceParams = {}

		for _, distanceStr in ipairs(distanceParamArr) do
			local distanceStrArr = string.split(distanceStr, "#")
			local distanceNum = distanceStrArr[1]

			distanceParams[tonumber(distanceNum)] = distanceStrArr[2]
		end

		local descStr = ""

		for distanceValue, desc in pairs(distanceParams) do
			if distanceValue <= distance then
				descStr = desc
			else
				break
			end
		end

		local dirStrEW = curCoord[1] < endCellCoord[1] and luaLang("text_dir_east") or curCoord[1] > endCellCoord[1] and luaLang("text_dir_west") or ""
		local dirStrNS = curCoord[2] < endCellCoord[2] and luaLang("text_dir_north") or curCoord[2] > endCellCoord[2] and luaLang("text_dir_south") or ""
		local mapId = params.mapId
		local contentCfgStr = Activity168Config.instance:getConstValueCfg(loperaActId, mapId).mlValue
		local contentParams = {
			descStr,
			dirStrEW .. dirStrNS
		}

		self._text.text = GameUtil.getSubPlaceholderLuaLang(contentCfgStr, contentParams)
	end
end

function LoperaLevelTipsView:_delayClose()
	TaskDispatcher.runDelay(self._doCloseAction, self, tipsDuration)
end

function LoperaLevelTipsView:_doCloseAction()
	self._viewAnimator:Play("out", 0, 0)
	TaskDispatcher.runDelay(self.closeThis, self, 0.25)
end

function LoperaLevelTipsView:_onGetToDestination(resultData)
	local reason = resultData.settleReason

	if LoperaEnum.ResultEnum.Quit == reason or LoperaEnum.ResultEnum.PowerUseup == reason then
		self:_doCloseAction()
	end
end

function LoperaLevelTipsView:_onMoveInEpisode()
	if not self._isFinishTips then
		self:_doCloseAction()
	end
end

function LoperaLevelTipsView:onExitGame()
	self:closeThis()
end

function LoperaLevelTipsView:onClose()
	return
end

function LoperaLevelTipsView:onDestroyView()
	TaskDispatcher.cancelTask(self.closeThis, self)
	TaskDispatcher.cancelTask(self._doCloseAction, self)
end

return LoperaLevelTipsView
