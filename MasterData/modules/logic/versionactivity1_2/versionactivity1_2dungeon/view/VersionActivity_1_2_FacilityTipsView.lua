-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity_1_2_FacilityTipsView.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_FacilityTipsView", package.seeall)

local VersionActivity_1_2_FacilityTipsView = class("VersionActivity_1_2_FacilityTipsView", BaseViewExtended)

function VersionActivity_1_2_FacilityTipsView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goroot = gohelper.findChild(self.viewGO, "#go_root")
	self._scrollinfo = gohelper.findChildScrollRect(self.viewGO, "#go_root/area/container/#scroll_info")
	self._goinfoitemcontent = gohelper.findChild(self.viewGO, "#go_root/area/container/#scroll_info/Viewport/Content")
	self._goinfoitem = gohelper.findChild(self.viewGO, "#go_root/area/container/#scroll_info/Viewport/Content/#go_infoitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity_1_2_FacilityTipsView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function VersionActivity_1_2_FacilityTipsView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function VersionActivity_1_2_FacilityTipsView:_btncloseOnClick()
	self:closeThis()
end

function VersionActivity_1_2_FacilityTipsView:_editableInitView()
	return
end

function VersionActivity_1_2_FacilityTipsView:onRefreshViewParam()
	return
end

function VersionActivity_1_2_FacilityTipsView:onOpen()
	self._configList = VersionActivity1_2DungeonModel.instance:getBuildingGainList()

	self:com_createObjList(self._onItemShow, self._configList, self._goinfoitemcontent, self._goinfoitem)
end

function VersionActivity_1_2_FacilityTipsView:_onItemShow(obj, data, index)
	local txt_title = gohelper.findChildText(obj, "txt_title")
	local content = gohelper.findChild(obj, "tips")
	local txt_info = gohelper.findChildText(obj, "tips/txt_info")

	txt_title.text = "【" .. data.name .. "】"

	if data.buildingType == 2 then
		local arr = string.split(data.configType, "|")

		self:com_createObjList(self._showType2DesItem, arr, content, txt_info.gameObject)
	else
		local arr = string.split(data.configType, "|")

		self:com_createObjList(self._showType3DesItem, arr, content, txt_info.gameObject)
	end
end

function VersionActivity_1_2_FacilityTipsView:_showType2DesItem(obj, data, index)
	local txt_info = gohelper.findChildText(obj, "")
	local arr = string.splitToNumber(data, "#")
	local addValue = arr[2]
	local attrConfig = lua_character_attribute.configDict[arr[1]]

	txt_info.text = attrConfig.type ~= 1 and attrConfig.name .. "<color=#d65f3c>+" .. tonumber(string.format("%.3f", addValue / 10)) .. "%</color>" or attrConfig.name .. "<color=#d65f3c>+" .. math.floor(addValue) .. "</color>"
end

function VersionActivity_1_2_FacilityTipsView:_showType3DesItem(obj, data, index)
	local txt_info = gohelper.findChildText(obj, "")
	local arr = string.splitToNumber(data, "#")
	local ruleConfig = lua_rule.configDict[arr[2]]

	txt_info.text = ruleConfig.desc
end

function VersionActivity_1_2_FacilityTipsView:onClose()
	return
end

function VersionActivity_1_2_FacilityTipsView:onDestroyView()
	return
end

return VersionActivity_1_2_FacilityTipsView
