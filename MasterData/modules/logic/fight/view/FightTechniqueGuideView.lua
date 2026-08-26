-- chunkname: @modules/logic/fight/view/FightTechniqueGuideView.lua

module("modules.logic.fight.view.FightTechniqueGuideView", package.seeall)

local FightTechniqueGuideView = class("FightTechniqueGuideView", BaseView)

function FightTechniqueGuideView:onInitView()
	self._gotargetframe = gohelper.findChild(self.viewGO, "#go_targetframe")
	self._goguidContent = gohelper.findChild(self.viewGO, "#go_guidContent")
	self._goguideitem = gohelper.findChild(self.viewGO, "#go_guidContent/#go_guideitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightTechniqueGuideView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function FightTechniqueGuideView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function FightTechniqueGuideView:_btncloseOnClick()
	self:closeThis()
end

function FightTechniqueGuideView:_editableInitView()
	return
end

function FightTechniqueGuideView:onUpdateParam()
	return
end

function FightTechniqueGuideView:onOpen()
	TaskDispatcher.cancelTask(FightWorkFocusMonster.showCardPart, FightWorkFocusMonster)

	self._entityMO = self.viewParam.entity
	self._config = self.viewParam.config

	FightWorkFocusMonster.focusCamera(self._entityMO.id)

	self._is_enter_type = self._config.invokeType == FightWorkFocusMonster.invokeType.Enter

	FightMsgMgr.sendMsg(FightMsgId.CameraFocusChanged, true)
	FightController.instance:dispatchEvent(FightEvent.OnCameraFocusChanged, true)

	self._show_des = string.split(self._config.des, "|")
	self._show_icon = string.split(self._config.icon, "|")
	self._isActivityVersion = string.split(self._config.isActivityVersion, "|")

	gohelper.CreateObjList(self, self._onItemShow, self._show_des, self._goguidContent, self._goguideitem)
	FightHelper.setMonsterGuideFocusState(self._config)
end

function FightTechniqueGuideView:_onItemShow(obj, data, index)
	local transform = obj.transform
	local simage_guideicon = gohelper.findChildSingleImage(obj, "simage_guideicon")
	local txt_desc = transform:Find("txt_desc"):GetComponent(gohelper.Type_TextMesh)
	local go_career = transform:Find("go_career").gameObject
	local content_str = self._show_des[index]

	content_str = string.gsub(content_str, "%【", string.format("<color=%s>", "#F87D42"))
	content_str = string.gsub(content_str, "%】", "</color>")
	txt_desc.text = content_str

	simage_guideicon:LoadImage(ResUrl.getFightTechniqueGuide(self._show_icon[index], self._isActivityVersion[index] == "1") or "")

	self._images = self._images or {}

	table.insert(self._images, simage_guideicon)

	local career_bg = gohelper.findChildImage(go_career, "image_bg")
	local enemy_career = lua_monster.configDict[self._entityMO.modelId].career
	local recommended_career

	if enemy_career ~= 5 and enemy_career ~= 6 then
		recommended_career = FightConfig.instance:restrainedBy(enemy_career)

		local color = {
			"#473115",
			"#192c40",
			"#243829",
			"#4d2525",
			"#462b48",
			"#564d26"
		}

		SLFramework.UGUI.GuiHelper.SetColor(career_bg, color[recommended_career])
		UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(go_career, "image_career"), "lssx_" .. recommended_career)
	end

	gohelper.setActive(go_career, recommended_career and index == 1)
end

function FightTechniqueGuideView:onClose()
	FightWorkFocusMonster.cancelFocusCamera()
end

function FightTechniqueGuideView:onDestroyView()
	if self._images then
		for i, v in ipairs(self._images) do
			v:UnLoadImage()
		end
	end

	self._images = nil
end

return FightTechniqueGuideView
