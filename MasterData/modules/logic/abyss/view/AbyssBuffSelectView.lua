-- chunkname: @modules/logic/abyss/view/AbyssBuffSelectView.lua

module("modules.logic.abyss.view.AbyssBuffSelectView", package.seeall)

local AbyssBuffSelectView = class("AbyssBuffSelectView", BaseView)

function AbyssBuffSelectView:onInitView()
	self._btnclosebg = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closebg")
	self._txtbuffname = gohelper.findChildText(self.viewGO, "titlebg/#txt_buffname")
	self._txtdesc = gohelper.findChildText(self.viewGO, "Scroll View/Viewport/Content/#txt_desc")
	self._btndress = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_dress")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	SkillHelper.addHyperLinkClick(self._txtdesc)
	MonoHelper.addNoUpdateLuaComOnceToGo(self._txtdesc.gameObject, FixTmpBreakLine)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AbyssBuffSelectView:addEvents()
	self._btnclosebg:AddClickListener(self._btnclosebgOnClick, self)
	self._btndress:AddClickListener(self._btndressOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function AbyssBuffSelectView:removeEvents()
	self._btnclosebg:RemoveClickListener()
	self._btndress:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function AbyssBuffSelectView:_btnclosebgOnClick()
	self:closeThis()
end

function AbyssBuffSelectView.onBuffItemClick(param)
	local target = param.target
	local index = param.index

	target:selectBuff(index)
end

function AbyssBuffSelectView:_btndressOnClick()
	if not self._curSelectIndex or self._curSelectIndex == 0 then
		return
	end

	local skillConfig = self._skillConfigList[self._curSelectIndex]

	if not skillConfig then
		return
	end

	AbyssController.instance:setStageBuff(self.stageId, skillConfig.id)
	self:closeThis()
end

function AbyssBuffSelectView:_btncloseOnClick()
	self:closeThis()
end

function AbyssBuffSelectView:_editableInitView()
	self._goitemgroup = gohelper.findChild(self.viewGO, "Left/itemgroup")
	self._gobuffitem = gohelper.findChild(self.viewGO, "Left/itemgroup/buffitem")
	self._imagebuffpreview = gohelper.findChildImage(self.viewGO, "buffbg/#img_buff")
	self._buffItemList = {}
	self._curSelectIndex = nil
end

function AbyssBuffSelectView:checkParam()
	local param = self.viewParam

	if not param or not param.actId or not param.stageId then
		logError("新深渊 没有活动数据")

		return
	end

	self.actId = param.actId
	self.stageId = param.stageId

	local skillIdList = AbyssConfig.instance:getStageSkillId(self.stageId)

	if not skillIdList or not next(skillIdList) then
		logError("新深渊 没有技能配置")

		return
	end

	self._skillConfigList = {}

	for _, skillId in ipairs(skillIdList) do
		local skillConfig = AbyssConfig.instance:getSkillConfig(skillId)

		if skillConfig then
			table.insert(self._skillConfigList, skillConfig)
		end
	end

	if not next(self._skillConfigList) then
		logError("新深渊 没有技能配置")

		return
	end

	self._defaultSelectIndex = 1

	local stageMo = AbyssModel.instance:getStageInfoMo(self.actId, self.stageId)

	if stageMo and stageMo.skillId and stageMo.skillId ~= 0 then
		for i, config in ipairs(self._skillConfigList) do
			if config.id == stageMo.skillId then
				self._defaultSelectIndex = i

				break
			end
		end
	end
end

function AbyssBuffSelectView:refreshSkillList()
	if not self._skillConfigList then
		return
	end

	gohelper.CreateObjList(self, self.onBuffItemCreate, self._skillConfigList, nil, self._gobuffitem)
end

function AbyssBuffSelectView:onBuffItemCreate(itemGo, skillConfig, index)
	local item = self._buffItemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = itemGo
		item.goSelect = gohelper.findChild(itemGo, "#go_select")
		item.imageBuffIcon = gohelper.findChildImage(itemGo, "#img_buff")
		item.btnSelect = gohelper.findChildButtonWithAudio(itemGo, "#btn_select")

		item.btnSelect:AddClickListener(self.onBuffItemClick, {
			target = self,
			index = index
		})

		self._buffItemList[index] = item
	end

	item.skillConfig = skillConfig
	item.index = index

	if not string.nilorempty(skillConfig.icon) then
		UISpriteSetMgr.instance:setAbyssSprite(item.imageBuffIcon, "jdsh_" .. skillConfig.icon)
	end

	gohelper.setActive(item.goSelect, false)
end

function AbyssBuffSelectView:selectBuff(index)
	self._curSelectIndex = index

	for i, item in ipairs(self._buffItemList) do
		gohelper.setActive(item.goSelect, i == index)
	end

	local skillConfig = self._skillConfigList[index]

	if skillConfig then
		self._txtbuffname.text = skillConfig.name
		self._txtdesc.text = SkillHelper.buildDesc(skillConfig.desc)

		if self._imagebuffpreview and not string.nilorempty(skillConfig.icon) then
			UISpriteSetMgr.instance:setAbyssSprite(self._imagebuffpreview, "jdsh_" .. skillConfig.icon)
		end
	end
end

function AbyssBuffSelectView:onUpdateParam()
	return
end

function AbyssBuffSelectView:onOpen()
	self:checkParam()
	self:refreshSkillList()
	self:selectBuff(self._defaultSelectIndex)
end

function AbyssBuffSelectView:onClose()
	return
end

function AbyssBuffSelectView:onDestroyView()
	if self._buffItemList and next(self._buffItemList) then
		for _, item in ipairs(self._buffItemList) do
			item.btnSelect:RemoveClickListener()
		end

		tabletool.clear(self._buffItemList)
	end
end

return AbyssBuffSelectView
