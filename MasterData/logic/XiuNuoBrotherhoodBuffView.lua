-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/view/XiuNuoBrotherhoodBuffView.lua

module("logic.extensions.xiunuobrotherhood.view.XiuNuoBrotherhoodBuffView", package.seeall)

local XiuNuoBrotherhoodBuffView = class("XiuNuoBrotherhoodBuffView", ViewComponent)

XiuNuoBrotherhoodBuffView.SelectBuff = {
	BuffB = 2,
	BuffA = 1
}

function XiuNuoBrotherhoodBuffView:ctor()
	return
end

function XiuNuoBrotherhoodBuffView:buildUI()
	XiuNuoBrotherhoodBuffView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnStart = GameUtil.asBtn(self:getGo("btnFight"))
	self._tableview = self:getGo("tableview")
	self._buffCell = self:getGo("buffCell")
	self._scrollListBuff = ScrollerList.create(self._tableview, self._buffCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))

	self._scrollListBuff:regReloadFinish(GameUtil.handler(self._loadBuffFinish, self))

	self._tableviewReward = self:getGo("totalReward")
	self._itemCell = self:getGo("itemScrollercell")
	self._scrollListReward = ScrollerList.create(self._tableviewReward, self._itemCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))

	self._scrollListReward:setCenterMode(true)

	self._txtZdl = self:getTxt("txtZdl")
	self._txtName = self:getTxt("txtName")
	self._imgGo = self:getGo("pet")
	self._buffNum = self:getTxt("txtNum")
end

function XiuNuoBrotherhoodBuffView:bindEvents()
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickFight, self)
end

function XiuNuoBrotherhoodBuffView:unbindEvents()
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnStart)
end

function XiuNuoBrotherhoodBuffView:onEnter()
	local params = self:getOpenParam()

	self._activityId = params[1]
	self._stageId = params[2]
	self._fightBossId = params[3]
	self._gameActivityId = params[4]
	self._activityCfg = XiuNuoBrotherhoodConfig.instance:getActivityCfg(self._activityId)
	self._stageCfg = XiuNuoBrotherhoodConfig.instance:getStageCfg(self._activityId, self._stageId)

	self:_initView()
	self:refreshView()

	self._buffNum.text = langPara("总buff效果数:%d/%d", self:getSelectCount(), self._stageCfg.buffMax)
end

function XiuNuoBrotherhoodBuffView:onExit()
	XiuNuoBrotherhoodModel.instance:saveTempBuff(self._activityId, self._stageId, self._selectBuffs)
	self._scrollListBuff:dispose()
	self._scrollListReward:dispose()
	uGuiUtil.clearImage(self._imgGo)
end

function XiuNuoBrotherhoodBuffView:refreshView()
	self._scrollListBuff:reloadData(self._stageCfg.buffTypes)

	local cfg = XiuNuoBrotherhoodConfig.instance:getBossPlanCfg(self._stageCfg.bossPlanId, self._fightBossId)

	if not string.nilorempty(cfg.prize) then
		local prizeStrs = string.split(cfg.prize, "#")

		self._scrollListReward:reloadData(prizeStrs)
	end

	local teamCfg = XiuNuoBrotherhoodConfig.instance:getEnemyTeam(cfg.creepsMasterId)

	self._txtName.text = teamCfg.name

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(teamCfg.showFaceId))

	if not modelCo then
		printError("t_model id not exist:" .. showFaceId)

		return
	end

	uGuiUtil.setSpriteToImage(self._imgGo, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	self._txtZdl.text = langPara("推荐战斗力:%d", teamCfg.recommendZdl)
	self._buffNum.text = langPara("总buff效果数:%d/%d", self:getSelectCount(), self._stageCfg.buffMax)
end

function XiuNuoBrotherhoodBuffView:_initView()
	self._selectBuffs = XiuNuoBrotherhoodModel.instance:getTempBuff(self._activityId, self._stageId)

	if self:getSelectCount() == 0 then
		self._firstEnter = true
	else
		for i, v in pairs(self._selectBuffs) do
			if v and v.lv and XiuNuoBrotherhoodModel.instance:getBuffInfoByType(i) then
				v.lv = XiuNuoBrotherhoodModel.instance:getBuffInfoByType(i).lv
			end
		end
	end
end

function XiuNuoBrotherhoodBuffView:_updateBuffCell(view, cell, buffType, tag)
	local go = cell.gameObject
	local img = goutil.findChildComponent(go, "img", "UIImageSpriteChange")
	local txtA = goutil.findChildTextComponent(go, "txtA")
	local txtB = goutil.findChildTextComponent(go, "txtB")
	local selectA = goutil.findChildComponent(go, "selectA", "UIImageSpriteChange")
	local selectB = goutil.findChildComponent(go, "selectB", "UIImageSpriteChange")
	local btnA = GameUtil.asBtn(goutil.findChild(go, "btnA"))
	local btnB = GameUtil.asBtn(goutil.findChild(go, "btnB"))
	local txtLv = goutil.findChildTextComponent(go, "txtLv")
	local info = XiuNuoBrotherhoodModel.instance:getBuffInfoByType(buffType) or {}
	local lv = math.max(self._activityCfg.initBuffLv, checknumber(info.lv))
	local exp = checknumber(info.exp)
	local cfg = XiuNuoBrotherhoodConfig.instance:getBuffTypeCfg(buffType, lv)
	local nextCfg = XiuNuoBrotherhoodConfig.instance:getBuffTypeCfg(buffType, lv + 1)

	txtLv.text = nextCfg and string.format("Lv%d\n%d/%d", lv, exp, nextCfg.exp) or string.format("Lv%d\n%d/%d", lv, cfg.exp, cfg.exp)

	img:ChangeSprite(cfg.resName)

	local buffACfg = XiuNuoBrotherhoodConfig.instance:getBuff(cfg.buffA)
	local buffBCfg = XiuNuoBrotherhoodConfig.instance:getBuff(cfg.buffB)

	txtA.text = buffACfg.des
	txtB.text = buffBCfg.des

	if self._firstEnter == true and self:getSelectCount() < self._stageCfg.buffMax then
		self._selectBuffs[buffType] = {
			id = XiuNuoBrotherhoodBuffView.SelectBuff.BuffA,
			lv = lv
		}
	end

	local isOnA = self._selectBuffs[buffType] and self._selectBuffs[buffType].id == XiuNuoBrotherhoodBuffView.SelectBuff.BuffA or false
	local isOnB = self._selectBuffs[buffType] and self._selectBuffs[buffType].id == XiuNuoBrotherhoodBuffView.SelectBuff.BuffB or false

	if isOnA then
		selectA:SetState(1)
	else
		selectA:SetState(0)
	end

	if isOnB then
		selectB:SetState(1)
	else
		selectB:SetState(0)
	end

	GameUtil.addClickHandler(btnA, function()
		self:_onClickBuff(buffType, XiuNuoBrotherhoodBuffView.SelectBuff.BuffA, lv)
	end)
	GameUtil.addClickHandler(btnB, function()
		self:_onClickBuff(buffType, XiuNuoBrotherhoodBuffView.SelectBuff.BuffB, lv)
	end)
end

function XiuNuoBrotherhoodBuffView:_clearBuffCell(cell)
	local go = cell.gameObject
	local selectA = goutil.findChildComponent(go, "selectA", "UIImageSpriteChange")
	local selectB = goutil.findChildComponent(go, "selectB", "UIImageSpriteChange")
	local btnA = GameUtil.asBtn(goutil.findChild(go, "btnA"))
	local btnB = GameUtil.asBtn(goutil.findChild(go, "btnB"))

	GameUtil.rmClickHandler(btnA)
	GameUtil.rmClickHandler(btnB)
end

function XiuNuoBrotherhoodBuffView:_updateRewardCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function XiuNuoBrotherhoodBuffView:_clearRewardCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function XiuNuoBrotherhoodBuffView:getSelectCount()
	local count = 0

	for i, v in pairs(self._selectBuffs) do
		if v then
			count = count + 1
		end
	end

	return count
end

function XiuNuoBrotherhoodBuffView:_onClickBuff(buffType, buffId, lv)
	local isOn = self._selectBuffs[buffType] and self._selectBuffs[buffType].id == buffId or false

	isOn = not isOn

	if self:getSelectCount() >= self._stageCfg.buffMax and isOn == true and not self._selectBuffs[buffType] then
		FloatWordMgr.instance:show(lang("当前选择数量已达上限"))

		return
	end

	self._selectBuffs[buffType] = isOn and {
		id = buffId,
		lv = lv
	} or nil
	self._buffNum.text = langPara("总buff效果数:%d/%d", self:getSelectCount(), self._stageCfg.buffMax)

	self._scrollListBuff:refresh()
end

function XiuNuoBrotherhoodBuffView:_onClickFight()
	if self:getSelectCount() < self._stageCfg.buffMax then
		FloatWordMgr.instance:show(lang("请勾选BUFF效果"))

		return
	end

	local res = {}

	for i, v in pairs(self._selectBuffs) do
		if v then
			local cfg = XiuNuoBrotherhoodConfig.instance:getBuffTypeCfg(i, v.lv)

			if v.id == XiuNuoBrotherhoodBuffView.SelectBuff.BuffA and cfg and cfg.buffA then
				table.insert(res, cfg.buffA)
			elseif v.id == XiuNuoBrotherhoodBuffView.SelectBuff.BuffB and cfg and cfg.buffB then
				table.insert(res, cfg.buffB)
			end
		end
	end

	local customFmtMo = XiuNuoBrotherhoodModel.instance:getCustomFmtMo()

	self._mainViewName, self._selectViewName, self._gameViewName = XiuNuoBrotherhoodModel.instance:getJumpViewNames()

	customFmtMo:initParams(self._activityId, self._stageId, self._fightBossId, res, self._gameActivityId, self._mainViewName, self._selectViewName, self._gameViewName)
	CustomFmtController.instance:showMissionView(customFmtMo)
	self:close()
end

function XiuNuoBrotherhoodBuffView:_loadBuffFinish()
	self._buffNum.text = langPara("总buff效果数:%d/%d", self:getSelectCount(), self._stageCfg.buffMax)
	self._firstEnter = false
end

return XiuNuoBrotherhoodBuffView
