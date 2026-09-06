-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetAttrPopUpView.lua

module("logic.extensions.bag.view.stack.PetAttrPopUpView", package.seeall)

local PetAttrPopUpView = class("PetAttrPopUpView", ViewComponent)
local AttrRank = {
	GameEnum.AttrType.Hp,
	GameEnum.AttrType.Attack,
	GameEnum.AttrType.DefensePhysical,
	GameEnum.AttrType.DefenseMagic,
	GameEnum.AttrType.Speed,
	GameEnum.AttrType.HitRate,
	GameEnum.AttrType.DodgeRate,
	GameEnum.AttrType.StrikeRate,
	GameEnum.AttrType.BlockRate,
	GameEnum.AttrType.CriticalRate,
	GameEnum.AttrType.AntiCriticalRate
}
local AttrName = {
	[GameEnum.AttrType.Attack] = "_attack",
	[GameEnum.AttrType.DefensePhysical] = "_physicalDefence",
	[GameEnum.AttrType.DefenseMagic] = "_magicDefence",
	[GameEnum.AttrType.Hp] = "_maxHp",
	[GameEnum.AttrType.Speed] = "_speed",
	[GameEnum.AttrType.HitRate] = "_hitRate",
	[GameEnum.AttrType.DodgeRate] = "_dodgeRate",
	[GameEnum.AttrType.StrikeRate] = "_strikeRate",
	[GameEnum.AttrType.BlockRate] = "_blockRate",
	[GameEnum.AttrType.CriticalRate] = "_criticalRate",
	[GameEnum.AttrType.AntiCriticalRate] = "_antiCriticalRate"
}

function PetAttrPopUpView:ctor()
	PetAttrPopUpView.super.ctor(self)
end

function PetAttrPopUpView:destroyUI()
	PetAttrPopUpView.super.destroyUI(self)
end

function PetAttrPopUpView:onExitFinished()
	PetAttrPopUpView.super.onExitFinished(self)
end

function PetAttrPopUpView:onEnterFinished()
	PetAttrPopUpView.super.onEnterFinished(self)
end

function PetAttrPopUpView:unbindEvents()
	PetAttrPopUpView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function PetAttrPopUpView:bindEvents()
	PetAttrPopUpView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function PetAttrPopUpView:onExit()
	PetAttrPopUpView.super.onExit(self)
end

function PetAttrPopUpView:buildUI()
	PetAttrPopUpView.super.buildUI(self)

	self._Content = goutil.findChild(self.mainGO, "content")
	self._adjustPosition = self._Content:GetComponent("UIAdjustPosition")
	self._customInput = UICustomInput.Get(self._Content)

	local _Grid = goutil.findChild(self.mainGO, "content/grid")
	local _Detail = goutil.findChild(self.mainGO, "content/detail")
	local attrGo = self._viewPresentor:getResInstance("ui/views/common/item_attr2.prefab")
	local attrDatailGo = self._viewPresentor:getResInstance("ui/views/common/item_attr3.prefab")

	attrGo.name = "item_attr"
	attrDatailGo.name = "item_attrDetail"

	attrGo.transform:SetParent(_Grid.transform, false)
	attrDatailGo.transform:SetParent(_Detail.transform, false)

	self._attrItems = ItemGroup.New(_Grid, nil, self._buildAttrItem, self)
	self._attrItemDetails = ItemGroup.New(_Detail, nil, self._buildAttrItem, self)
	self._title2 = self:getGo("content/title_2")
end

function PetAttrPopUpView:_buildAttrItem(go, item)
	item._ImgC_Icon = goutil.findChildComponent(go, "ImgC_Icon", "UIImageSpriteChange")
	item._TxtC_Name = goutil.findChildTextComponent(go, "TxtC_Name")
	item._TxtC_Value = goutil.findChildTextComponent(go, "TxtC_Value")
	item._ImgC_Score = goutil.findChildComponent(go, "ImgC_Score", "UIImageSpriteChange")
end

function PetAttrPopUpView:_updateAttr(item, data)
	local rank = data.attrRank
	local value = checknumber(data.value)

	item._ImgC_Icon:SetState(rank - 1)

	item._TxtC_Name.text = ConstString.Attr[rank]

	if value > 0 and value < 1 then
		value = GameUtil.getMillesimalStr(value * 1000)
	end

	local lifeSum, attackSum, defendSum, magicSum = 0, 0, 0, 0
	local fixLifeSum, fixAttackSum, fixDefendSum, fixMagicSum = 0, 0, 0, 0

	if self.petMo then
		if self.petMo.isMyPackPet == false then
			lifeSum, attackSum, defendSum, magicSum = HandbookController.instance:calculateSumAttrOther(self.petMo)
			fixLifeSum, fixAttackSum, fixDefendSum, fixMagicSum = HandbookController.instance:calculateSumFixAttrOther(self.petMo)
		else
			lifeSum, attackSum, defendSum, magicSum = HandbookController.instance:calculateSumAttr()
			fixLifeSum, fixAttackSum, fixDefendSum, fixMagicSum = HandbookController.instance:calculateSumFixAttr()
		end
	end

	local color = "#20B376FF"
	local attValue = 0
	local fixAttValue = 0

	if rank == GameEnum.AttrType.Hp then
		attValue = lifeSum
		fixAttValue = fixLifeSum
	elseif rank == GameEnum.AttrType.Attack then
		attValue = attackSum
		fixAttValue = fixAttackSum
	elseif rank == GameEnum.AttrType.DefensePhysical then
		attValue = defendSum
		fixAttValue = fixDefendSum
	elseif rank == GameEnum.AttrType.DefenseMagic then
		attValue = magicSum
		fixAttValue = fixMagicSum
	end

	item._TxtC_Value.text = checknumber(attValue) ~= 0 and checknumber(fixAttValue) ~= 0 and langPara("%s<color=%s>+%s%%(+%s)</color>", value, color, attValue, fixAttValue) or checknumber(attValue) == 0 and checknumber(fixAttValue) ~= 0 and langPara("%s<color=%s>+%s</color>", value, color, fixAttValue) or checknumber(attValue) ~= 0 and checknumber(fixAttValue) == 0 and langPara("%s<color=%s>+%s%%</color>", value, color, attValue) or value

	item._ImgC_Score.gameObject:SetActive(false)

	if not type(self.petMo) == "string" then
		local propertyName = GameEnum.PetAttrScoreTitle[rank]
		local score = BagPetsController.instance:getPetAttrScore(self.petMo, propertyName)

		if score ~= nil and score >= GameEnum.PetAttrScore.D and score <= GameEnum.PetAttrScore.SSS then
			item._ImgC_Score.gameObject:SetActive(true)
			item._ImgC_Score:SetState(score)
		end
	end
end

function PetAttrPopUpView:onEnter()
	PetAttrPopUpView.super.onEnter(self)

	local params = self:getOpenParam()
	local petMo = params[3]
	local attrs = {}
	local attrDetail = {}

	self.petMo = petMo

	if type(petMo) == "string" then
		local t = string.split(petMo, "#")

		for _, v in ipairs(t) do
			local attr = string.split(v, "+")
			local data = {}

			data.attrRank = self:getAttrRankByLang(attr[1])
			data.value = attr[2]

			if checknumber(data.value) < 1 then
				table.insert(attrDetail, data)
			else
				table.insert(attrs, data)
			end
		end

		GameUtil.setHeight(self._Content, 360)
	else
		if petMo == nil then
			petMo = BagPetsController.instance:GetCurPetMo()
			self.petMo = petMo
		end

		for _, v in ipairs(AttrRank) do
			local data = {}

			data.attrRank = v
			data.value = petMo[AttrName[v]]

			if data.value < 1 then
				table.insert(attrDetail, data)
			else
				table.insert(attrs, data)
			end
		end

		GameUtil.setHeight(self._Content, 620)
	end

	self:_adjustView()

	self.petMo = petMo

	HandbookController.instance:checkDataAndCall(function()
		self._attrItems:updateWithMoArray(attrs, self._updateAttr, self)
		self._attrItemDetails:updateWithMoArray(attrDetail, self._updateAttr, self)
	end, self)
	GameUtil.SetActive(self._title2, #attrDetail > 0)
end

function PetAttrPopUpView:getAttrRankByLang(lang)
	for k, v in pairs(ConstString.Attr) do
		if v == lang then
			return k
		end
	end

	return 1
end

function PetAttrPopUpView:_adjustView()
	local pos = self._viewPresentor._openParam[1]
	local sizeDelta = self._viewPresentor._openParam[2]

	if pos then
		GameUtil.SetActive(self.mainGO, false)
		GameUtil.SetActive(self.mainGO, true)
		self._adjustPosition:AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])
	else
		Framework.TransformUtil.SetLocalPos(self._Content.transform, 0, 0, 0)
	end
end

function PetAttrPopUpView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

return PetAttrPopUpView
