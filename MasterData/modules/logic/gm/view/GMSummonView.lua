-- chunkname: @modules/logic/gm/view/GMSummonView.lua

module("modules.logic.gm.view.GMSummonView", package.seeall)

local GMSummonView = class("GMSummonView", BaseView)

GMSummonView._Type2Name = {
	AllSummon = 4,
	DiffRarity = 1,
	DiffRarityCount = 2,
	UpSummon = 3
}

function GMSummonView:onInitView()
	self._goContent = gohelper.findChild(self.viewGO, "node/infoScroll/Viewport/#go_Content")
	self._click = gohelper.findChildButton(self.viewGO, "node/close")
	self._itemList = {}
	self._paragraphItems = self:getUserDataTb_()

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GMSummonView:addEvents()
	self._click:AddClickListener(self.closeThis, self)
end

function GMSummonView:removeEvents()
	self._click:RemoveClickListener()
end

function GMSummonView:onOpen()
	self._poolId, self._totalCount, self._star6TotalCount, self._star5TotalCount = GMSummonModel.instance:getAllInfo()

	self:_initView()
end

function GMSummonView:_initView()
	self:cleanParagraphs()

	for i = 1, 3 do
		local item = self._itemList[i]

		item = item or self:getUserDataTb_()
		item.go = gohelper.findChild(self.viewGO, "node/infoScroll/Viewport/#go_Content/#go_infoItem" .. i)
		item.txtdesctitle = gohelper.findChildText(item.go, "desctitle/#txt_desctitle")

		self:_createParagraphUI(i, item)
	end
end

function GMSummonView:_createParagraphUI(type, item)
	if type == GMSummonView._Type2Name.DiffRarity then
		local infos = GMSummonModel.instance:getDiffRaritySummonHeroInfo()

		for index, value in ipairs(infos) do
			local textItem = self:createParaItem(item.go)

			textItem.text = value.star .. "星：" .. value.per * 100 .. "% (" .. value.num .. "/" .. self._totalCount .. ")"
		end
	elseif type == GMSummonView._Type2Name.DiffRarityCount then
		local infos = GMSummonModel.instance:getDiffRaritySummonShowInfo()

		for index, value in ipairs(infos) do
			local textItem = self:createParaItem(item.go)

			textItem.text = value.star .. "星：" .. value.num
		end
	elseif type == GMSummonView._Type2Name.UpSummon then
		local totalUpInfo, otherInfo = GMSummonModel.instance:getUpHeroInfo()
		local textItem = self:createParaItem(item.go)

		textItem.text = "UP角色"

		self:createUPParaItem(item.go, totalUpInfo)

		local textItem = self:createParaItem(item.go)

		textItem.text = "\n非UP角色"

		self:createUPParaItem(item.go, otherInfo)
	elseif type == GMSummonView._Type2Name.AllSummon then
		local infos = GMSummonModel.instance:getAllSummonHeroInfo()

		for index, value in ipairs(infos) do
			local textItem = self:createParaItem(item.go)
			local heroName = GMSummonModel.instance:getTargetName(value.id)

			textItem.text = "(" .. value.star .. "星)" .. heroName .. "：" .. value.per * 100 .. "% (" .. value.num .. "/" .. self._totalCount .. ")"
		end
	end
end

function GMSummonView:createUPParaItem(parent, info)
	for index, value in ipairs(info) do
		local textItem = self:createParaItem(parent)
		local heroName = GMSummonModel.instance:getTargetName(value.id)

		if value.star == 6 then
			textItem.text = "(" .. value.star .. "星)" .. heroName .. "：" .. value.per * 100 .. "% (" .. value.num .. "/" .. self._star6TotalCount .. ")"
		elseif value.star == 5 then
			textItem.text = "(" .. value.star .. "星)" .. heroName .. "：" .. value.per * 100 .. "% (" .. value.num .. "/" .. self._star5TotalCount .. ")"
		end
	end
end

function GMSummonView:createParaItem(parent)
	local paraItem
	local goTarget = gohelper.findChild(parent, "#txt_descContent")

	paraItem = gohelper.cloneInPlace(goTarget, "para_1")

	local textItem = paraItem:GetComponent(gohelper.Type_TextMesh)

	gohelper.setActive(paraItem, true)
	table.insert(self._paragraphItems, paraItem)

	return textItem
end

function GMSummonView:cleanParagraphs()
	for i = #self._paragraphItems, 1, -1 do
		gohelper.destroy(self._paragraphItems[i])

		self._paragraphItems[i] = nil
	end
end

return GMSummonView
