-- chunkname: @modules/logic/prototest/view/ProtoTestFileItem.lua

module("modules.logic.prototest.view.ProtoTestFileItem", package.seeall)

local ProtoTestFileItem = class("ProtoTestFileItem", ListScrollCell)

function ProtoTestFileItem:init(go)
	self._txtFileName = gohelper.findChildText(go, "Txt_casefile")
	self._btnRecover = gohelper.findChildButtonWithAudio(go, "Btn_recover")
	self._btnLoad = gohelper.findChildButtonWithAudio(go, "Btn_load")
	self._btnAppend = gohelper.findChildButtonWithAudio(go, "Btn_append")
end

function ProtoTestFileItem:addEventListeners()
	self._btnRecover:AddClickListener(self._onClickBtnRecover, self)
	self._btnLoad:AddClickListener(self._onClickBtnLoad, self)
	self._btnAppend:AddClickListener(self._onClickBtnAppend, self)
end

function ProtoTestFileItem:removeEventListeners()
	self._btnRecover:RemoveClickListener()
	self._btnLoad:RemoveClickListener()
	self._btnAppend:RemoveClickListener()
end

function ProtoTestFileItem:onUpdateMO(mo)
	self._mo = mo
	self._txtFileName.text = mo.id .. ". " .. mo.fileName
end

function ProtoTestFileItem:_onClickBtnRecover()
	local list = ProtoTestCaseModel.instance:getList()

	ProtoTestMgr.instance:saveToFile(self._mo.fileName, list)
end

function ProtoTestFileItem:_onClickBtnLoad()
	local list = ProtoTestMgr.instance:readFromFile(self._mo.fileName)

	for i, mo in ipairs(list) do
		mo.id = i
	end

	ProtoTestCaseModel.instance:setList(list)
end

function ProtoTestFileItem:_onClickBtnAppend()
	local list = ProtoTestMgr.instance:readFromFile(self._mo.fileName)
	local oldList = ProtoTestCaseModel.instance:getList()
	local oldListCount = #oldList

	for i, newMO in ipairs(list) do
		newMO.id = i + oldListCount

		table.insert(oldList, newMO)
	end

	ProtoTestCaseModel.instance:setList(oldList)
end

return ProtoTestFileItem
