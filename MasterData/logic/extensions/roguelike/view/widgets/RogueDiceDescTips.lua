-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RogueDiceDescTips.lua

module("logic.extensions.roguelike.view.widgets.RogueDiceDescTips", package.seeall)

local DescItemType1 = class("DescItemType1")

function DescItemType1:ctor(container)
	local go = container.gameObject

	self._go = go
	self._imgIcon = goutil.findChildImageComponent(go, "icon")
	self._txtNum = goutil.findChildTextComponent(go, "icon/txtNum")
	self._goHead = goutil.findChild(go, "dice_hero_head")
	self._goHeadLeft = goutil.findChild(go, "dice_hero_head_left")
	self._headItem = Astral.LuaComponentContainer.Add(self._goHead, RogueDiceRoleHeadItem)
	self._headItemLeft = Astral.LuaComponentContainer.Add(self._goHeadLeft, RogueDiceRoleHeadItem)
end

function DescItemType1:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function DescItemType1:setHead(data)
	local headData = {}

	if data.isRole then
		headData.roleId = data.sourceId
	else
		headData.monsterId = data.sourceId
	end

	self._headItemLeft:updateData(headData)
end

function DescItemType1:updateData(data)
	if data.pattern then
		IconLoader.setSprite(self._imgIcon, IconType.DynSpriteAtlas_Dice, string.format("ptxr_tb_%d", RoguelikeConst.GetPatterIcon(data.pattern)))
	end

	if data.diceCount then
		self._txtNum.text = string.format("x%d", data.diceCount)
	end

	goutil.setActive(self._imgIcon.gameObject, data.pattern ~= nil)

	local headData = {}

	if data.isRole then
		headData.roleId = data.targetId
	else
		local prop = RogueMgr.instance:getModel():getCurMonster().monsterProp

		headData.monsterId = data.targetId or prop:getId()
	end

	headData.icon = data.icon
	headData.iconType = data.iconType
	headData.hpChange = data.hpChange
	headData.entryId = data.entryId
	headData.entryCount = data.entryCount

	self._headItem:updateData(headData)
	self:setActive(true)
end

local DescItemType2 = class("DescItemType2")

function DescItemType2:ctor(container)
	local go = container.gameObject

	self._go = go
	self._imgIcon = goutil.findChildImageComponent(go, "icon")
	self._txtNum = goutil.findChildTextComponent(go, "icon/txtNum")
	self._imgEffect = goutil.findChildImageComponent(go, "Image2")
	self._txtEffectNum = goutil.findChildTextComponent(go, "txtNum")
	self._goHeadLeft = goutil.findChild(go, "dice_hero_head_left")
	self._headItemLeft = Astral.LuaComponentContainer.Add(self._goHeadLeft, RogueDiceRoleHeadItem)
end

function DescItemType2:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function DescItemType2:setHead(data)
	local headData = {}

	if data.isRole then
		headData.roleId = data.sourceId
	else
		headData.monsterId = data.sourceId
	end

	self._headItemLeft:updateData(headData)
end

function DescItemType2:updateData(data)
	goutil.setActive(self._imgIcon.gameObject, false)

	if data.defenceCount ~= nil then
		self._txtEffectNum.text = data.defenceCount > 0 and "+" .. data.defenceCount or data.defenceCount
	end

	self:setActive(true)
end

local DescItemNormal = class("DescItemNormal")

function DescItemNormal:ctor(container)
	local go = container.gameObject

	self._go = go
	self._imgIcon = goutil.findChildImageComponent(go, "Image1/icon")
	self._txtNum = goutil.findChildTextComponent(go, "Image1/txtNum")
	self._goHeadLeft = goutil.findChild(go, "leftHead")
	self._goHeadRight = goutil.findChild(go, "rightHead")
	self._headItemLeft = Astral.LuaComponentContainer.Add(self._goHeadLeft, RogueDiceRoleHeadItem)
	self._headItemRight = Astral.LuaComponentContainer.Add(self._goHeadRight, RogueDiceRoleHeadItem)
end

function DescItemNormal:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function DescItemNormal:setHead(data)
	local headData = {}

	if data.isRole then
		headData.roleId = data.sourceId
	else
		headData.monsterId = data.sourceId
	end

	self._headItemLeft:updateData(headData)
end

function DescItemNormal:updateData(data)
	local spriteName = "pt_icon_gongji"

	if data.diceCount then
		self._txtNum.text = string.format("x%d", data.diceCount)
		spriteName = string.format("ptxr_tb_%d", RoguelikeConst.GetPatterIcon(data.pattern))
	end

	if data.defenceCount ~= nil then
		self._txtNum.text = data.defenceCount > 0 and data.defenceCount or data.defenceCount
		spriteName = "pt_icon_fangyu"
	end

	if data.hpChange then
		self._txtNum.text = data.hpChange > 0 and data.hpChange or data.hpChange * -1
		spriteName = "pt_icon_gongji"
	end

	if data.entryId then
		self._txtNum.text = data.entryCount > 0 and data.entryCount or data.entryCount
		spriteName = "pt_icon_jiatou"
	end

	IconLoader.setSprite(self._imgIcon, IconType.DynSpriteAtlas_Dice, spriteName)

	local headData = {}

	headData.icon = data.icon
	headData.iconType = data.iconType
	headData.hpChange = data.hpChange
	headData.entryId = data.entryId
	headData.entryCount = data.entryCount

	if data.isRole then
		headData.roleId = data.targetId
	else
		headData.monsterId = data.targetId
	end

	self._headItemRight:updateData(headData)
	self:setActive(true)
end

local M = class("RogueDiceDescTips")

function M:ctor(go)
	self._go = go.gameObject
end

function M:Awake()
	self:onInit()
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function M:onInit()
	local go = self._go

	self._goItemType1 = goutil.findChild(go, "itemType1")
	self._itemType1List = {}
end

function M:updateData(data)
	local roundDatas = RogueBroadcastModel.instance:getMoBySourceIdAndRound(data.sourceId, data.round)
	local headData = {}

	if data.isRole then
		headData.roleId = data.sourceId
	else
		headData.monsterId = data.sourceId
	end

	local item1Index = 0

	for k, v in pairs(self._itemType1List) do
		v:setActive(false)
	end

	if #roundDatas == 0 then
		FloatWordMgr.instance:show(lang("本轮没有记录"))

		return
	end

	for k, v in pairs(roundDatas) do
		if v.pattern == nil and not v.hpChange and v.entryId == nil then
			-- block empty
		end

		item1Index = item1Index + 1

		local item = self._itemType1List[item1Index]

		if not item then
			local go = goutil.cloneAndSetParent(self._goItemType1, self._go.transform)

			item = Astral.LuaComponentContainer.Add(go, DescItemNormal)
			self._itemType1List[item1Index] = item
		end

		item:updateData(v)
		item:setHead(data)
	end

	self:setActive(true)
end

function M:setPosY(posY)
	local pos = self._go.transform.position

	pos.y = posY
	self._go.transform.position = pos
end

function M:OnDestroy()
	return
end

return M
