-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/DiscountDressIdlePreView.lua

module("logic.extensions.dressactivityshop.view.DiscountDressIdlePreView", package.seeall)

local DiscountDressIdlePreView = class("DiscountDressIdlePreView", ViewComponent)

function DiscountDressIdlePreView:ctor()
	DiscountDressIdlePreView.super.ctor(self)
end

function DiscountDressIdlePreView:unbindEvents()
	DiscountDressIdlePreView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DiscountDressIdlePreView:bindEvents()
	DiscountDressIdlePreView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DiscountDressIdlePreView:buildUI()
	DiscountDressIdlePreView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._showL = self:getGo("show_1/display/img")
	self._showR = self:getGo("show_2/display/img")
	self._effectL = self:getGo("show_1/effect")
	self._effectR = self:getGo("show_2/effect")
end

function DiscountDressIdlePreView:onExit()
	DiscountDressIdlePreView.super.onExit(self)
	self._photoEffL:clear()
	self._photoEffR:clear()

	if self._avatar then
		self._avatar:removeListener(AvatarNotify.OnSetParentFinish, self.onMaleLoadEnd, self)
		AvatarsMgrNew.instance:removeAvatar(self._avatar)

		self._avatar = nil
	end

	if self._avatar2 then
		self._avatar2:removeListener(AvatarNotify.OnSetParentFinish, self.onFemaleLoadEnd, self)
		AvatarsMgrNew.instance:removeAvatar(self._avatar2)

		self._avatar2 = nil
	end

	for _, effect in ipairs(self._effctList) do
		if effect then
			UIEffectManager.instance:stopEffect(effect)
		end
	end

	self._effctList = nil
end

function DiscountDressIdlePreView:onEnter()
	DiscountDressIdlePreView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.MoorDiscountDressGift)

	self:_showRoleModel()
end

function DiscountDressIdlePreView:_showRoleModel()
	self._effctList = {}
	self._currId = 1
	self._discountCfg = DressSellConfig.instance:getDiscountCfgById(self._activityId, self._currId)
	self._photoEffL = AvatarPhotoShow.Get(self._showL)
	self._avatar = self:addAvatarShow(GameEnum.Gender.Male, self._photoEffL)

	self._photoEffL:setRawWidthAndHeight(516, 750)
	self._photoEffL:setCameraPosition(0, 1.08, -5)
	self._photoEffL:setCamSize(1.3)
	self._photoEffL:setRTAdjust(1, 1, 1, 0.45)

	self._photoEffR = AvatarPhotoShow.Get(self._showR)
	self._avatar2 = self:addAvatarShow(GameEnum.Gender.Female, self._photoEffR)

	self._photoEffR:setRawWidthAndHeight(516, 750)
	self._photoEffR:setCameraPosition(0, 1.08, -5)
	self._photoEffR:setCamSize(1.3)
	self._photoEffR:setRTAdjust(1, 1, 1, 0.45)
	self._avatar:addListener(AvatarNotify.OnSetParentFinish, self.onMaleLoadEnd, self)
	self._avatar2:addListener(AvatarNotify.OnSetParentFinish, self.onFemaleLoadEnd, self)
end

function DiscountDressIdlePreView:onFemaleLoadEnd(avatar)
	local avatarGo = avatar:getGameObject()

	if avatarGo then
		self:_playEffect(self._effectR)
	end
end

function DiscountDressIdlePreView:onMaleLoadEnd(avatar)
	local avatarGo = avatar:getGameObject()

	if avatarGo then
		self:_playEffect(self._effectL)
	end
end

function DiscountDressIdlePreView:addAvatarShow(gender, photoEff)
	local mo = gender == GameEnum.Gender.Female and AvatarConfig.instance:getAvatarMoByCfgId(1) or AvatarConfig.instance:getAvatarMoByCfgId(2)
	local params = string.splitToNumber(self._discountCfg.addParams, "#")
	local curDressCfgs = {}

	for i, v in ipairs(params) do
		local cfg = MaterialMgr.getMatCfg(MatType.Cloth, checkint(v))

		if cfg and (cfg.clothesGender == GameEnum.Gender.Neutral or cfg.clothesGender == gender) then
			table.insert(curDressCfgs, cfg)
		end
	end

	for i, v in ipairs(curDressCfgs) do
		local cfg = curDressCfgs[i]

		if cfg then
			mo:dressCloth(cfg.id)
		end
	end

	local avatar = AvatarsMgrNew.instance:getAvatarByMo(mo)

	photoEff:addShowAvatarEffect(avatar)

	return avatar
end

function DiscountDressIdlePreView:_playEffect(parent)
	local path = {
		"avatars/skinedmeshes/otherres/fxeffests/fx_1089_bsn/fx_1089_bsn_guadian.prefab"
	}
	local effect = UIEffectManager.instance:playEffect(self, path, parent, 0, 0, true, nil, nil, function(target, eff)
		eff:setClipping(parent.transform)
	end, self)

	effect:setParent(parent.transform)
	effect:setLocalPos(0, 0, 0)
	effect:setScale(1)
	table.insert(self._effctList, effect)
end

return DiscountDressIdlePreView
