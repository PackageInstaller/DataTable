-- chunkname: @modules/logic/versionactivity2_3/act174/view/outside/Act174BadgeWallView.lua

module("modules.logic.versionactivity2_3.act174.view.outside.Act174BadgeWallView", package.seeall)

local Act174BadgeWallView = class("Act174BadgeWallView", BaseView)

function Act174BadgeWallView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act174BadgeWallView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Act174BadgeWallView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Act174BadgeWallView:_btncloseOnClick()
	self:closeThis()
end

function Act174BadgeWallView:_editableInitView()
	return
end

function Act174BadgeWallView:onUpdateParam()
	return
end

function Act174BadgeWallView:onOpen()
	self:freshBadgeItem()
end

function Act174BadgeWallView:onClose()
	return
end

function Act174BadgeWallView:onDestroyView()
	for _, icon in ipairs(self.badgeIconList) do
		icon:UnLoadImage()
	end
end

function Act174BadgeWallView:freshBadgeItem()
	local actInfo = Activity174Model.instance:getActInfo()
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

return Act174BadgeWallView
