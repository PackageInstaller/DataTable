-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/rare/RareCell.lua

module("logic.extensions.material.proxy.rare.RareCell", package.seeall)

local RareCell = class("RareCell", MaterialCell)

function RareCell:ctor(target)
	RareCell.super.ctor(self, target)

	self.imgList = {}

	for i = 1, 4 do
		local go = goutil.findChild(target, "img" .. i)

		table.insert(self.imgList, go)
		GameUtil.SetActive(go, false)
	end

	self.eff = goutil.findChild(target, "eff")
	self._targetObj = target.gameObject
	self._img4 = goutil.findChild(self._targetObj, "img4")
end

function RareCell:setCfgData(cfg)
	RareCell.super.setCfgData(self, cfg)

	if cfg then
		local rare = CharacterConfig.instance:getRareByAwakenLv(cfg.initAwakenLv, cfg.raceId)

		for i = 1, #self.imgList do
			local go = self.imgList[i]

			GameUtil.SetActive(go, i == rare)
		end

		self:playStaticEffect(rare)
	end
end

function RareCell:setRare(rare)
	for i = 1, #self.imgList do
		local go = self.imgList[i]

		GameUtil.SetActive(go, i == rare)
	end

	self:playStaticEffect(rare)
end

function RareCell:playStaticEffect(rare)
	print("playStaticEffect ")

	if rare == nil and self.cfg then
		rare = CharacterConfig.instance:getRareByAwakenLv(self.cfg.initAwakenLv, self.cfg.raceId)
	end

	local petCfg

	if self.cfg then
		petCfg = CharacterConfig.instance:getPetCo(self.cfg.raceId)
	end

	local url = "fx_ui_mangmianban/new/fx_ui_chuanshuo_daizi.prefab"

	UIEffectManager.instance:stopEffect(self._effSSR)

	if petCfg and PetSkinConfig.instance:checkHasJob(petCfg.raceId, GameEnum.JobZhDefine.SourceTrace) then
		url = "fx_ui_chuanshuo_daizi_yq/fx_ui_chuanshuo_daizi_yq.prefab"
		self._effSSR = self:playCellEffect("fx_ui_chuanshuo_daizi_yq/fx_ui_chuanshuo_daizi_yq.prefab", self._img4, function(finishHandlerTarget, eff)
			eff:setScale(0.7)

			local trans = eff.effGo.transform

			Framework.TransformUtil.SetLocalPos(trans, -5, 10, 0)
		end)
	elseif rare == MatType.Rare_SSR then
		self._effSSR = self:playCellEffect(url, self._img4)
	end
end

function RareCell:playEffect()
	local rare = CharacterConfig.instance:getRareByAwakenLv(self.cfg.initAwakenLv, self.cfg.raceId)

	if self._effRare ~= nil then
		UIEffectManager.instance:stopEffect(self._effRare)
	end

	self._effRare = nil

	local url

	if rare == MatType.Rare_SR then
		url = "fx_ui_sr/fx/ani_sr.prefab"
	elseif rare == MatType.Rare_SSR then
		url = "fx_ui_mangmianban/new/fx_ui_chuanshuo_yici.prefab"
	end

	if not string.nilorempty(url) then
		self._effRare = self:playCellEffect(url, self.eff)
	end
end

function RareCell:addEff(petCo)
	local rare = CharacterConfig.instance:getRareByAwakenLv(petCo.initAwakenLv, petCo.raceId)

	if rare == MatType.Rare_SR then
		self:playEff("fx_ui_huoyuedu")
	elseif rare == MatType.Rare_SSR then
		self:playEff("fx_ui_huoyuedu")
	else
		self:stopEff()
	end
end

function RareCell:playEff(effName)
	self:stopEff()

	local url = "fx_ui_renwu/" .. effName .. ".prefab"

	self._effect = self:playCellEffect(url, self.eff)

	self._effect:setScale(1)

	self._effect.sortingOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(self.target)
end

function RareCell:stopEff()
	UIEffectManager.instance:stopEffect(self._effect)

	self._effect = nil

	UIEffectManager.instance:stopEffect(self._effRare)

	self._effRare = nil

	UIEffectManager.instance:stopEffect(self._effSSR)

	self._effSSR = nil
end

function RareCell:dispose()
	RareCell.super.dispose(self)
	self:stopEff()
end

return RareCell
