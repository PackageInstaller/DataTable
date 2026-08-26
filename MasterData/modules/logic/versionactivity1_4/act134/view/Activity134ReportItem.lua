-- chunkname: @modules/logic/versionactivity1_4/act134/view/Activity134ReportItem.lua

module("modules.logic.versionactivity1_4.act134.view.Activity134ReportItem", package.seeall)

local Activity134ReportItem = class("Activity134ReportItem", LuaCompBase)

function Activity134ReportItem:init(template, viewGO)
	self.template = template
	self.viewGO = viewGO

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity134ReportItem:addEvents()
	return
end

function Activity134ReportItem:removeEvents()
	return
end

function Activity134ReportItem:_editableInitView()
	return
end

function Activity134ReportItem:_editableAddEvents()
	return
end

function Activity134ReportItem:_editableRemoveEvents()
	return
end

function Activity134ReportItem:onDestroy()
	for _, v in ipairs(self.charaterIcon) do
		v:UnLoadImage()
	end
end

function Activity134ReportItem:initMo(index, mo)
	self.index = index
	self.mo = mo
	self.typeList = {}

	local type = mo.storyType

	self.charaterIcon = {}

	for i, v in ipairs(mo.desc) do
		local item = gohelper.clone(self.template, self.viewGO, i)

		gohelper.setActive(item.gameObject, true)

		if type == 1 then
			self:setItemOneType(v, item)
		elseif type == 2 then
			self:setItemTwoType(v, item)
		elseif type == 3 then
			self:setItemThreeType(v, item)
		else
			self:setItemFourType(v, item)
		end
	end
end

function Activity134ReportItem:setItemOneType(mo, item)
	local _simagerole = gohelper.findChildSingleImage(item, "bg/#simage_role")
	local _txttitle = gohelper.findChildText(item, "right/#txt_title")
	local _txtdec = gohelper.findChildText(item, "right/#txt_dec")

	if not string.nilorempty(mo.charaterIcon) then
		local icon = string.format("v1a4_dustyrecords_role_" .. mo.charaterIcon)

		_simagerole:LoadImage(ResUrl.getV1a4DustRecordsIcon(icon))
		table.insert(self.charaterIcon, _simagerole)
	end

	local str = string.split(mo.desc, "<split>")

	if #str > 1 then
		_txttitle.text = str[1]
		_txtdec.text = str[2]
	end
end

function Activity134ReportItem:setItemTwoType(mo, item)
	local _txtdec = gohelper.findChildText(item, "bg/#txt_dec")
	local _txtname = gohelper.findChildText(item, "bg/#txt_name")

	_txtdec.text = mo.desc

	if mo.formMan then
		_txtname.text = mo.formMan or ""
	end
end

function Activity134ReportItem:setItemThreeType(mo, item)
	local _txtdec = gohelper.findChildText(item, "#txt_dec")

	_txtdec.text = mo.desc
end

function Activity134ReportItem:setItemFourType(mo, item)
	local _txtdec = gohelper.findChildText(item, "#txt_dec")

	_txtdec.text = mo.desc
end

return Activity134ReportItem
