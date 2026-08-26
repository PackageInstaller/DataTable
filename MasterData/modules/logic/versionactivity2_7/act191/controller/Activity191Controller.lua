-- chunkname: @modules/logic/versionactivity2_7/act191/controller/Activity191Controller.lua

module("modules.logic.versionactivity2_7.act191.controller.Activity191Controller", package.seeall)

local Activity191Controller = class("Activity191Controller", BaseController)

function Activity191Controller:getActId()
	self.actId = self.actId or VersionActivity3_8Enum.ActivityId.DouQuQu4

	return self.actId
end

function Activity191Controller:getStoreId()
	self.storeId = self.storeId or VersionActivity3_8Enum.ActivityId.DouQuQu4Store

	return self.storeId
end

function Activity191Controller:enterActivity()
	local actId = self:getActId()

	Activity191Rpc.instance:sendGetAct191InfoRequest(actId, self.enterReply, self)
end

function Activity191Controller:enterReply(_, resultCode)
	if resultCode == 0 then
		self:openMainView()
	end
end

function Activity191Controller:openMainView(param)
	ViewMgr.instance:openView(ViewName.Act191MainView, param)
end

function Activity191Controller:openFetterTipView(param)
	ViewMgr.instance:openView(ViewName.Act191FetterTipView, param)
end

function Activity191Controller:openStoreView()
	local storeId = self:getStoreId()

	if not VersionActivityEnterHelper.checkCanOpen(storeId) then
		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(storeId, self._openStoreViewAfterRpc, self)
end

function Activity191Controller:openResultPanel(isWin)
	ViewMgr.instance:openView(ViewName.Act191FightSuccView, isWin)
end

function Activity191Controller:openSettlementView()
	ViewMgr.instance:openView(ViewName.Act191SettlementView)
end

function Activity191Controller:openHeroTipView(param)
	ViewMgr.instance:openView(ViewName.Act191HeroTipView, param)
end

function Activity191Controller:openCollectionTipView(param)
	ViewMgr.instance:openView(ViewName.Act191CollectionTipView, param)
end

function Activity191Controller:openEnhanceTipView(param)
	ViewMgr.instance:openView(ViewName.Act191EnhanceTipView, param)
end

function Activity191Controller:openItemView(itemCo)
	ViewMgr.instance:openView(ViewName.Act191ItemView, itemCo)
end

function Activity191Controller:_openStoreViewAfterRpc(_, resultCode)
	if resultCode == 0 then
		ViewMgr.instance:openView(ViewName.Act191StoreView)
	end
end

function Activity191Controller:nextStep()
	local actId = Activity191Model.instance:getCurActId()
	local gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	if gameInfo.state == Activity191Enum.GameState.None then
		logError("游戏数据异常,GameInfo的State为None")
	elseif gameInfo.state == Activity191Enum.GameState.Normal then
		if gameInfo.curStage == 0 and gameInfo.curNode == 0 then
			ViewMgr.instance:openView(ViewName.Act191InitBuildView)
		else
			local nodeInfo = Activity191Helper.matchKeyInArray(gameInfo.nodeInfo, gameInfo.curNode, "nodeId")

			if not nodeInfo then
				logError("nodeInfos中不存在节点ID: " .. gameInfo.curNode)

				return
			end

			if string.nilorempty(nodeInfo.nodeStr) then
				ViewMgr.instance:openView(ViewName.Act191StageView)

				if gameInfo.nodeChange then
					ViewMgr.instance:openView(ViewName.Act191SwitchView)
				end
			else
				local mo = Act191NodeDetailMO.New()

				mo:init(nodeInfo.nodeStr)

				if Activity191Helper.isShopNode(mo.type) then
					ViewMgr.instance:openView(ViewName.Act191ShopView)
				elseif mo.type == Activity191Enum.NodeType.Enhance then
					ViewMgr.instance:openView(ViewName.Act191EnhancePickView, mo)
				elseif mo.type == Activity191Enum.NodeType.RewardEvent then
					ViewMgr.instance:openView(ViewName.Act191AdventureView, mo)
				elseif mo.type == Activity191Enum.NodeType.BattleEvent then
					ViewMgr.instance:openView(ViewName.Act191AdventureView, mo)
				elseif Activity191Helper.isPveBattle(mo.type) then
					self:enterFightScene(mo)
				elseif Activity191Helper.isPvpBattle(mo.type) then
					self:enterFightScene(mo)
				elseif mo.type == Activity191Enum.NodeType.ReplaceEvent or mo.type == Activity191Enum.NodeType.UpgradeEvent then
					ViewMgr.instance:openView(ViewName.Act191CollectionChangeView)
				end
			end
		end
	elseif gameInfo.state == Activity191Enum.GameState.End then
		Activity191Rpc.instance:sendEndAct191GameRequest(actId)
	end
end

function Activity191Controller:enterFightScene(mo)
	local episodeId

	if Activity191Helper.isPveBattle(mo.type) or mo.type == Activity191Enum.NodeType.BattleEvent then
		local eventId = mo.fightEventId

		episodeId = lua_activity191_fight_event.configDict[eventId].episodeId
	elseif Activity191Helper.isPvpBattle(mo.type) then
		episodeId = tonumber(lua_activity191_const.configDict[Activity191Enum.ConstKey.PvpBattleEpisodeId].value)
	end

	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterId = episodeCo.chapterId

	DungeonModel.instance:SetSendChapterEpisodeId(chapterId, episodeId)

	local fightParam = FightController.instance:setFightParamByEpisodeAndBattle(episodeId, episodeCo.battleId)

	fightParam:setPreload()
	FightController.instance:enterFightScene()
end

function Activity191Controller:checkOpenGetView()
	local actInfo = Activity191Model.instance:getActInfo()
	local hasGet = false

	for _, v in ipairs(actInfo.triggerEffectPushList) do
		if not string.nilorempty(v.param) then
			hasGet = true

			break
		end
	end

	if not hasGet then
		actInfo:clearTriggerEffectPush()
	end

	return hasGet
end

Activity191Controller.instance = Activity191Controller.New()

return Activity191Controller
