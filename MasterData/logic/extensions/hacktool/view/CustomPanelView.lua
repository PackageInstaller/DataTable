-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/CustomPanelView.lua

module("logic.extensions.hacktool.view.CustomPanelView", package.seeall)

local M = class("CustomPanelView")
local panelType = {
	echo = 2,
	think = 3,
	equip = 1,
	skill = 4
}

function M:ctor(container)
	self._go = container.gameObject
	self._data = {}
	self._type = false
	self._select = {}
end

function M:Awake()
	self:init()
end

function M:setPresentor(presentor)
	self._presentor = presentor
end

function M:init()
	self._txtFilter = goutil.findChildTextComponent(self._go, "view/text")
	self._btnConfirm = UIComponentType.ButtonAdapter(goutil.findChild(self._go, "view/btnConfirm"))
	self._txtName = goutil.findChildTextComponent(self._go, "view/text1")
	self._txtAttr = goutil.findChildTextComponent(self._go, "view/text2")
	self._txtEchoEnhance = goutil.findChildTextComponent(self._go, "view/text5")
	self._txtContent = goutil.findChildComponent(self._go, "view/input", UIComponentType.TextMeshProUGUI)

	local itemScroll = goutil.findChildComponent(self._go, "view/scroll", UIComponentType.ScrollRect)

	self._loopList = LoopGridViewHelper.New(itemScroll.gameObject)

	self._loopList:InitGridView(0, self._updateGrid, self)
	self:bindEvents()
end

function M:bindEvents()
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
end

function M:unbindEvents()
	self._btnConfirm:RemoveClickListener()
end

function M:OnDestroy()
	self:unbindEvents()
end

function M:refreshData(data, type)
	self._data = data
	self._filterData = data
	self._type = type

	self._loopList:SetListItemCount(#self._data)
	self._loopList:RefreshAllShownItem()
end

function M:refreshFilter()
	local hero = ""
	local career = ""

	if self._presentor then
		local select = self._presentor:getSelectHero()

		hero = select:getName()
		career = CommEnum.Career2Name[select:getItemInfo().career]
	end

	self._txtFilter.text = string.format("当前筛选角色：%s  职业：%s", hero, career)
	self._filterData = {}

	if career == "" then
		return
	end

	local selectCareer = self._presentor:getSelectHero():getItemInfo().career

	for _, item in ipairs(self._data) do
		if item.career == selectCareer or item.career == 0 then
			table.insert(self._filterData, item)
		end
	end

	self._loopList:SetListItemCount(#self._filterData)
	self._loopList:RefreshAllShownItem()
end

function M:_updateGrid(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopList:NewListViewItem("item")
	local component = Astral.LuaComponentContainer.Add(item.transform:GetChild(0).gameObject, SimpleHackCell)

	component:getComponent("normal"):setClickListener(self._onClickCell, self)
	component:updateData(self._filterData[curIndex])

	return item
end

function M:_onClickCell(cell)
	local data = cell:getData()

	self._select = data

	if self._type == panelType.equip then
		self._txtName.text = "套装名：" .. data.name
		self._txtContent.text = self:_getSkillDesc(data.suitEffect)
	elseif self._type == panelType.echo then
		self._txtName.text = "残响名：" .. data.name
		self._txtAttr.text = string.format("品质：%s\t职业：%s", CommEnum.Qua2Score[data.quality], CommEnum.Career2Name[data.career])

		local attrLst = EchoItemConfig.instance:getAttrLst(data.id, 1)
		local str = ""

		for idx, val in pairs(attrLst) do
			local item = attrLst[idx]
			local cfgAttDefine = AttributeDefineConfig.instance:getAttributePartDefineCO(item.id)

			if cfgAttDefine then
				local offsetNumStr = item.num

				if item.num < 1 then
					offsetNumStr = string.format("+%s", item.num * 100) .. "%"
				end

				str = str .. cfgAttDefine.name .. ":" .. offsetNumStr .. "\n"
			end
		end

		self._txtEchoEnhance.text = str

		local echoItemData = ItemUtil.createItemData({
			itemId = data.id
		})
		local skillEnhanceMO = echoItemData:getSkillEnhanceMO()
		local descStr = skillEnhanceMO and skillEnhanceMO:getDescriptionTagHighLight(false) or ""

		self._txtContent.text = descStr
	elseif self._type == panelType.think then
		self._txtName.text = "思维名：" .. data.name
		self._txtContent.text = data.description
	elseif self._type == panelType.skill then
		self._txtName.text = "技能名：" .. data.name
		self._txtAttr.text = "技能ID：" .. data.id
		self._txtContent.text = self:_getSkillDesc(data.id)
	end
end

function M:_onClickConfirm()
	self._presentor:setSelect(self._type, self._select)
	goutil.setActive(self._go, false)
end

function M:_getSkillDesc(skillId)
	local skillMo = SkillEnhanceMO.getSharedMO(skillId)

	skillMo:rebuild()

	local desc = skillMo:getDescription(true)

	SkillEnhanceMO.releaseSharedMO(skillMo)

	return desc
end

return M
