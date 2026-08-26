-- chunkname: @modules/logic/fight/view/magiccircle/FightMagicCircleLSJ.lua

module("modules.logic.fight.view.magiccircle.FightMagicCircleLSJ", package.seeall)

local FightMagicCircleLSJ = class("FightMagicCircleLSJ", FightMagicCircleBaseItem)

function FightMagicCircleLSJ:getUIType()
	return FightEnum.MagicCircleUIType.LSJ
end

local resPath = "ui/viewres/fight/fight_lusijian_shuzhenview.prefab"

function FightMagicCircleLSJ:initView()
	self.preLevel = 0
	self.loaded = false
	self.loader = PrefabInstantiate.Create(self.go)

	self.loader:startLoad(resPath, self.onLoadCallback, self)
end

function FightMagicCircleLSJ:onLoadCallback()
	self.rectTr = self.go:GetComponent(gohelper.Type_RectTransform)
	self.instanceGo = self.loader:getInstGO()
	self.animator = self.instanceGo:GetComponent(gohelper.Type_Animator)
	self.goLevel1 = gohelper.findChild(self.instanceGo, "Root/#go_Icon1")
	self.goLevel2 = gohelper.findChild(self.instanceGo, "Root/#go_Icon2")
	self.goLevel3 = gohelper.findChild(self.instanceGo, "Root/#go_Icon3")
	self.goLevel4 = gohelper.findChild(self.instanceGo, "Root/#go_Icon4")

	gohelper.setActive(self.goLevel1, true)
	gohelper.setActive(self.goLevel2, true)
	gohelper.setActive(self.goLevel3, true)
	gohelper.setActive(self.goLevel4, true)

	self.goRound = gohelper.findChild(self.instanceGo, "Root/Num/num")
	self.goRoundInfinity = gohelper.findChild(self.instanceGo, "Root/Num/txt_Infiniti")
	self.txtRound = gohelper.findChildText(self.instanceGo, "Root/Num/num/#txt_num")
	self.txtRoundInfinity = gohelper.findChildText(self.instanceGo, "Root/Num/txt_Infiniti")
	self.click = gohelper.getClickWithDefaultAudio(self.instanceGo)

	self.addClickCb(self, self.click, self.onClickSelf, self)

	self.loaded = true

	if self.magicMo and self.magicConfig then
		self:onCreateMagic(self.magicMo, self.magicConfig)
	end

	self.addEventCb(self, FightController.instance, FightEvent.UpgradeMagicCircile, self.onUpgradeMagicCircle, self)
end

function FightMagicCircleLSJ:onUpgradeMagicCircle(magicMo)
	local magicConfig = lua_magic_circle.configDict[magicMo.magicCircleId]

	self:refreshUI(magicMo, magicConfig)
end

function FightMagicCircleLSJ:onClickSelf()
	local preferredHeight = recthelper.getHeight(self.rectTr)
	local position = self.rectTr.position

	FightController.instance:dispatchEvent(FightEvent.OnClickMagicCircleText, preferredHeight, position)
end

function FightMagicCircleLSJ:onCreateMagic(magicMo, magicConfig)
	self.magicMo = magicMo
	self.magicConfig = magicConfig

	if not self.loaded then
		return
	end

	FightMagicCircleLSJ.super.onCreateMagic(self, magicMo, magicConfig)
end

function FightMagicCircleLSJ:onUpdateMagic(magicMo, magicConfig, fromId)
	self.magicMo = magicMo
	self.magicConfig = magicConfig

	if not self.loaded then
		return
	end

	FightMagicCircleLSJ.super.onUpdateMagic(self, magicMo, magicConfig, fromId)
end

function FightMagicCircleLSJ:refreshUI(magicMo, magicConfig)
	self.magicMo = magicMo
	self.magicConfig = magicConfig

	if not self.loaded then
		return
	end

	self:refreshRound()
	self:refreshLevel()
end

function FightMagicCircleLSJ:refreshRound()
	local isInfinity = self.magicMo.round == -1

	gohelper.setActive(self.goRound, not isInfinity)
	gohelper.setActive(self.goRoundInfinity, isInfinity)

	self.txtRound.text = self.magicMo.round == -1 and "∞" or self.magicMo.round
end

function FightMagicCircleLSJ:refreshLevel()
	local co = lua_magic_wqsz.configDict[self.magicMo.magicCircleId]

	if co then
		if not co.level then
			local curLevel = 0

			if curLevel == self.preLevel then
				return
			end

			AudioMgr.instance:trigger(340024)

			if curLevel < self.preLevel then
				self.animator:Play("sub")
			else
				local level = math.max(0, curLevel - 1)

				self.animator:Play("leve" .. level)
			end

			self.preLevel = curLevel
		end
	end
end

function FightMagicCircleLSJ:destroy()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	FightMagicCircleLSJ.super.destroy(self)
end

return FightMagicCircleLSJ
