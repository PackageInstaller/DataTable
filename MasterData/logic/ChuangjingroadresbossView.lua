-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadresbossView.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadresbossView", package.seeall)

local ChuangjingroadresbossView = class("ChuangjingroadresbossView", ViewComponent)

function ChuangjingroadresbossView:ctor()
	ChuangjingroadresbossView.super.ctor(self)
end

function ChuangjingroadresbossView:unbindEvents()
	ChuangjingroadresbossView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnEnter)
end

function ChuangjingroadresbossView:bindEvents()
	ChuangjingroadresbossView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickHelp, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickEnter, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
end

function ChuangjingroadresbossView:buildUI()
	ChuangjingroadresbossView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnEnter = self:getGo("btnEnter")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtName = self:getTxt("petInfo/txtName")
	self._con = self:getGo("con")
	self._bubble = self:getGo("bubble")
	self._txtCost = MaterialMgr.findGraphicText(self.mainGO, "bubble/txt")
	self._rewardCell = self:getGo("progressReward/rewardCell")
	self._tableview = self:getGo("progressReward/tableview")
	self._txtDamage = self:getTxt("progressReward/total/txt")
	self._progressBar = self:getSlider("progressReward/tableview/Viewport/Content/progressBar")
	self._rewardScrollList = ScrollerList.create(self._tableview, self._rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
end

function ChuangjingroadresbossView:onExit()
	ChuangjingroadresbossView.super.onExit(self)

	self._loader = RoleObjectPool.instance:removeRole(self._loader)
end

function ChuangjingroadresbossView:onEnter()
	ChuangjingroadresbossView.super.onEnter(self)

	self._activityId = 396001
	self._zoneId = 1

	local params = self:getOpenParam() or {}
	local actId = checknumber(params[1])
	local zoneId = checknumber(params[2])

	if actId > 0 then
		self._activityId = actId
	end

	if zoneId > 0 then
		self._zoneId = zoneId
	end

	self.addGEvent(self, GlobalNotify.CHUANG_JING_ROAD_INFO_UPDATE, self._onRefershUI, self)
	ChuangJingRoadController.instance:sendGetInfo(self._activityId)
	self:_onRefershUI()
end

function ChuangjingroadresbossView:_onRefershUI()
	local info = ChuangJingRoadModel.instance:getInfo(self._activityId) or {}
	local todayPaidBoss = checkbool(info.todayPaidBoss)

	GameUtil.SetActive(self._bubble, not todayPaidBoss)

	self._todayMaxBossDamage = checknumber(info.todayMaxBossDamage)

	local cfg = ChuangJingRoadConfig.instance:getActivityCfgById(self._activityId) or {}
	local type, id, num = MaterialMgr.getMatParams(cfg.fightBossCost)
	local iconStr = MaterialMgr.getContentMatStr(cfg.fightBossCost, 26, -5, MaterialMgr.ICON_TYPE_ICON)

	self._txtCost.text = langPara("首次挑战需要%s%s", num, iconStr)
	self._txtDamage.text = self._todayMaxBossDamage

	local prizeList = ChuangJingRoadConfig.instance:getBossPrizeListById(self._activityId) or {}
	local idx = -1
	local scoreArr = {}

	for i, v in ipairs(prizeList) do
		table.insert(scoreArr, v.damage)

		if self._todayMaxBossDamage >= v.damage then
			idx = i - 1
		end
	end

	self._rewardScrollList:reloadData(prizeList)
	self._rewardScrollList:updateUnderSlider(self._progressBar, self._todayMaxBossDamage, scoreArr)
	self._rewardScrollList:MoveCellToCenter(idx == -1 and 0 or idx)
	self:_showPetSkin(self:_getSkinId())
end

function ChuangjingroadresbossView:_onClickEnter()
	ChuangJingRoadController.instance:openResBossMissionView(self._activityId)
end

function ChuangjingroadresbossView:_onClickHelp()
	return
end

function ChuangjingroadresbossView:_showPetSkin(raceId)
	local skinId = raceId
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self._con, scale, function(go)
					return
				end, true, modelCfg[1], y)
				self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, skinId)

				MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
			end
		end
	end
end

function ChuangjingroadresbossView:_getSkinId()
	local cfg = ChuangJingRoadConfig.instance:getActivityCfgById(self._activityId) or {}

	return cfg.bossRaceId or 10017
end

function ChuangjingroadresbossView:_onClickInfo()
	local skinId = self:_getSkinId()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	if cfg then
		local raceId = cfg.raceId

		PetbookController.instance:openPetinfoView(raceId)
	end
end

function ChuangjingroadresbossView:_onClickSkill()
	local skinId = self:_getSkinId()

	PetbookController.instance:previewBattleWithSkinId(skinId)
end

function ChuangjingroadresbossView:_updateRewardCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")
	local received = goutil.findChild(cell, "received")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local canGet = goutil.findChild(cell, "canGet")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.setCellByCfg(data.prize, item)

	local num = data.damage / 10000

	txtScore.text = num >= 1 and num .. "w" or data.damage

	local isCanGet = self._todayMaxBossDamage >= data.damage

	GameUtil.SetActive(canGet, false)
	GameUtil.SetActive(received, isCanGet)
end

function ChuangjingroadresbossView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.resetAll(item)
end

return ChuangjingroadresbossView
