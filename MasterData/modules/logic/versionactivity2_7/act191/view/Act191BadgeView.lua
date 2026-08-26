-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191BadgeView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191BadgeView", package.seeall)

local Act191BadgeView = class("Act191BadgeView", BaseView)

function Act191BadgeView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191BadgeView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Act191BadgeView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Act191BadgeView:_btncloseOnClick()
	self:closeThis()
end

function Act191BadgeView:_editableInitView()
	return
end

function Act191BadgeView:onOpen()
	Act191StatController.instance:onViewOpen(self.viewName)

	local actInfo = Activity191Model.instance:getActInfo()
	local badgeMoList = actInfo:getBadgeMoList()

	self.badgeIconList = {}

	for i = 1, 8 do
		local go = gohelper.findChild(self.viewGO, "badgeitem" .. i)
		local badgeMo = badgeMoList[i]

		if badgeMo then
			local simageIcon = gohelper.findChildSingleImage(go, "badgeIcon/root/image_icon")
			local txtNum = gohelper.findChildText(go, "badgeIcon/root/txt_num")
			local txtName = gohelper.findChildText(go, "txt_name")
			local txtDesc = gohelper.findChildText(go, "scroll_desc/Viewport/content/txt_desc")

			txtNum.text = badgeMo.count
			txtName.text = badgeMo.config.name
			txtDesc.text = badgeMo.config.desc

			local state = badgeMo:getState()
			local path = ResUrl.getAct174BadgeIcon(badgeMo.config.icon, state)

			simageIcon:LoadImage(path)

			self.badgeIconList[i] = simageIcon
		end
	end
end

function Act191BadgeView:onClose()
	local manual = self.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(self.viewName, manual)
end

function Act191BadgeView:onDestroyView()
	for _, icon in ipairs(self.badgeIconList) do
		icon:UnLoadImage()
	end
end

return Act191BadgeView
