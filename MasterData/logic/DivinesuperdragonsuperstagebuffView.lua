-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinesuperdragon/view/DivinesuperdragonsuperstagebuffView.lua

module("logic.extensions.divinesuperdragon.view.DivinesuperdragonsuperstagebuffView", package.seeall)

local DivinesuperdragonsuperstagebuffView = class("DivinesuperdragonsuperstagebuffView", ViewComponent)

function DivinesuperdragonsuperstagebuffView:ctor()
	DivinesuperdragonsuperstagebuffView.super.ctor(self)
end

function DivinesuperdragonsuperstagebuffView:unbindEvents()
	DivinesuperdragonsuperstagebuffView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function DivinesuperdragonsuperstagebuffView:bindEvents()
	DivinesuperdragonsuperstagebuffView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function DivinesuperdragonsuperstagebuffView:buildUI()
	DivinesuperdragonsuperstagebuffView.super.buildUI(self)

	self._txtDesc = self:getTxt("root/bg/txtDesc")
	self._bgGo = self:getGo("root/bg")
	self._customInput = UICustomInput.Get(self._bgGo)
	self._txttablecellGo = self:getGo("root/bg/tablecell")
	self._txttableviewGo = self:getGo("root/bg/tableview")
	self._txtScrollerList = ScrollerList.create(self._txttableviewGo, self._txttablecellGo, GameUtil.handler(self._updateTxtCell, self), GameUtil.handler(self._clearTxtCell, self))

	self._txtScrollerList:regGetCellSize(function(view, index)
		return self:_getTxtCellSize(index)
	end)
end

function DivinesuperdragonsuperstagebuffView:onExit()
	DivinesuperdragonsuperstagebuffView.super.onExit(self)
	self._txtScrollerList:dispose()
end

function DivinesuperdragonsuperstagebuffView:onEnter()
	DivinesuperdragonsuperstagebuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = DivinesuperdragonController.instance:getActivityId()
	end

	self:_setDesc()
end

function DivinesuperdragonsuperstagebuffView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

function DivinesuperdragonsuperstagebuffView:_setDesc()
	local datas = {}
	local info = DivinesuperdragonModel.instance:getInfo(self._activityId)

	if info then
		for i, v in ipairs(info.buffStageIdPassed) do
			local cfg = DivinesuperdragonConfig.instance:getBuffStageCfg(self._activityId, v)

			table.insert(datas, {
				desc = cfg.buffDesc
			})
		end
	end

	if #datas <= 0 then
		table.insert(datas, {
			desc = "未激活星宙加成"
		})
	end

	self._txtList = datas

	self._txtScrollerList:reloadData(datas)
end

function DivinesuperdragonsuperstagebuffView:_updateTxtCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")

	txtDesc.text = data.desc
end

function DivinesuperdragonsuperstagebuffView:_clearTxtCell(cell)
	return
end

function DivinesuperdragonsuperstagebuffView:_getTxtCellSize(index)
	if self._txtList and self._txtList[index + 1] then
		local input = self._txtList[index + 1].desc

		input = string.trim(input)

		local nonChineseLength, chineseLength = self:_countChineseAndNonChinese(input)

		nonChineseLength = nonChineseLength / 2

		return 255, math.ceil((nonChineseLength + chineseLength) / 14 + 1) * 20
	end

	return 255, 100
end

function DivinesuperdragonsuperstagebuffView:_countChineseAndNonChinese(str)
	local nonChineseLength = 0
	local chineseLength = 0

	for uchar in string.gmatch(str, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*") do
		if string.byte(uchar) >= 228 then
			chineseLength = chineseLength + 1
		else
			nonChineseLength = nonChineseLength + 1
		end
	end

	return nonChineseLength, chineseLength
end

return DivinesuperdragonsuperstagebuffView
