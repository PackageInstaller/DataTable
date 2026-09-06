-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godlongyan/view/LongYanSQMainView.lua

module("logic.extensions.godlongyan.view.LongYanSQMainView", package.seeall)

local LongYanSQMainView = class("LongYanSQMainView", ViewComponent)

function LongYanSQMainView:ctor()
	LongYanSQMainView.super.ctor(self)
end

function LongYanSQMainView:buildUI()
	LongYanSQMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnOneKey = self:getBtn("btnOneKey")
	self._btnBuff = self:getBtn("btnBuff")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._btnTip = self:getBtn("btnTip")
	self._oneKeyItem = self:getGo("oneKeyItem/item")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnIntroduce = self:getBtn("petInfo/btnIntroduce")
	self._txtName = self:getTxt("petInfo/txtName")
	self._roleGo = self:getGo("role")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._goldBarCon = self:getGo("goldBarCon")
	self._redPoint = self:getGo("btnBuff/redPoint")
end

function LongYanSQMainView:bindEvents()
	LongYanSQMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnOneKey:AddClickListener(self._onClickOneKey, self)
	self._btnBuff:AddClickListener(self._onClickBuff, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	self._btnIntroduce:AddClickListener(self._onClickIntroduce, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function LongYanSQMainView:unbindEvents()
	LongYanSQMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnOneKey:RemoveClickListener()
	self._btnBuff:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnIntroduce:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function LongYanSQMainView:onEnter()
	LongYanSQMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GodLongYanChallengeOneKeyPassRes, self._onOneKeyPassRes, self)
	GlobalDispatcher:addListener(GlobalNotify.GodLongYanChallengeGetInfoRes, self._updateRedPoint, self)
	GlobalDispatcher:addListener(GlobalNotify.GodLongYanUpgradeBuff, self._updateRedPoint, self)

	self._challengeId = self:getFirstParam()
	self._cfgChallenge = GodLongYanConfig.instance:getGlyData(self._challengeId)
	self._evolveCfg = EvolveConfig.instance:getDivineEvolveCfgByChallengeId(self._challengeId)
	self._petCfg = CharacterConfig.instance:getPetCo(self._evolveCfg.newRaceId)

	self:_initShow()
	self:_setGoldBar(self._cfgChallenge.consume)
	self:_updateRedPoint()
	GodLongYanController.instance:onSendGodLongYanChallengeGetInfoReq()
end

function LongYanSQMainView:onExit()
	LongYanSQMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GodLongYanChallengeOneKeyPassRes, self._onOneKeyPassRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.GodLongYanChallengeGetInfoRes, self._updateRedPoint, self)
	GlobalDispatcher:removeListener(GlobalNotify.GodLongYanUpgradeBuff, self._updateRedPoint, self)
	self:_clearItem()
end

function LongYanSQMainView:_onClickClose()
	self:close()
end

function LongYanSQMainView:_onClickOneKey()
	local isPassed = DivineEvolveModel.instance:isFinishEvolveChallenge(self._challengeId)

	if not isPassed then
		local cfgChallenge = GodLongYanConfig.instance:getGlyData(self._challengeId)

		if cfgChallenge then
			local type, id, num = MaterialMgr.getMatParams(self._cfgChallenge.oneKeyPassPrize)
			local name = MaterialMgr.getMaterialsName(type, id)
			local payCfg = PayConfig.instance:getPayGoodsCfg(cfgChallenge.goodsId)
			local text = string.format("是否确认花费%s元一键通关神启挑战？\n额外赠送%s*%s，并获得未通关的关卡奖励。", (payCfg or nil) and checknumber(payCfg.payMoney) / 100, name, num)

			local function okFunc()
				PayController.instance:pay(cfgChallenge.goodsId, GameEnum.PaySubGoodsType.GOD_LONG_YAN_CHALLENGE, self._challengeId)
			end

			local okFuncText = lang("confirm")
			local cancelFuncText = lang("cancel")

			TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc, cencelFunc, okFuncText, cancelFuncText)
		end
	else
		FloatWordMgr.instance:show("已通过龙炎神启挑战")
	end
end

function LongYanSQMainView:_onClickBuff()
	UIStateManager.instance:push(ViewName.LongYanSQBuffView)
end

function LongYanSQMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.LongYanSQLevelView, self._challengeId)
end

function LongYanSQMainView:_onClickSkill()
	if self._evolveCfg then
		PetbookController.instance:previewBattle(self._evolveCfg.newRaceId)
	end
end

function LongYanSQMainView:_onClickIntroduce()
	if self._evolveCfg then
		PetbookController.instance:openPetinfoView(self._evolveCfg.newRaceId)
	end
end

function LongYanSQMainView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "shenqiDragon_rule")
end

function LongYanSQMainView:_onOneKeyPassRes()
	local function callback()
		UIStateManager.instance:popByName(ViewName.LongYanSQMainView)
		GodLongYanController.instance:showOneKeyReward()
	end

	UIStateManager.instance:push(ViewName.DivineEvolveTipView, callback)
end

function LongYanSQMainView:_initShow()
	if not string.nilorempty(self._cfgChallenge.oneKeyPassPrize) then
		MaterialMgr.setCellByCfg(self._cfgChallenge.oneKeyPassPrize, self._oneKeyItem)
	end

	self._txtName.text = self._petCfg.name

	self:_showRole(self._petCfg.raceId)
	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.setCell(MatType.Rare, self._petCfg.raceId, self._pointRare)
end

function LongYanSQMainView:_clearItem()
	MaterialMgr.resetAll(self._oneKeyItem)
	self:_resetRole()
end

function LongYanSQMainView:_showRole(skinId)
	self:_resetRole()

	local offset = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, skinId, self._roleGo, scale, nil, true, x, y)
end

function LongYanSQMainView:_resetRole()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function LongYanSQMainView:_setGoldBar(coinStr)
	local matMo = string.splitToNumber(coinStr, ":")
	local name = matMo[1] .. ":" .. matMo[2]
	local objList = {
		{
			showAdd = false,
			id = name
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
end

function LongYanSQMainView:_updateRedPoint()
	goutil.setActive(self._redPoint, GodLongYanModel.instance:isAnyBuffCanUpgrade())
end

return LongYanSQMainView
