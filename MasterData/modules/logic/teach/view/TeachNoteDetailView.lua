-- chunkname: @modules/logic/teach/view/TeachNoteDetailView.lua

module("modules.logic.teach.view.TeachNoteDetailView", package.seeall)

local TeachNoteDetailView = class("TeachNoteDetailView", BaseView)

function TeachNoteDetailView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg2")
	self._simagebg3 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg3")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txtnameen = gohelper.findChildText(self.viewGO, "#txt_nameen")
	self._goitemdescs = gohelper.findChild(self.viewGO, "#go_itemdescs")
	self._godescitem = gohelper.findChild(self.viewGO, "#go_itemdescs/#go_descitem")
	self._gonotetip = gohelper.findChild(self.viewGO, "#go_notetip")
	self._txtnotedesc = gohelper.findChildText(self.viewGO, "#go_notetip/#txt_notedesc")
	self._btnlearn = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_learn")
	self._txtlearnstart = gohelper.findChildText(self.viewGO, "#btn_learn/start")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TeachNoteDetailView:addEvents()
	self._btnlearn:AddClickListener(self._btnlearnOnClick, self)
end

function TeachNoteDetailView:removeEvents()
	self._btnlearn:RemoveClickListener()
end

function TeachNoteDetailView:_btnlearnOnClick()
	local config = DungeonConfig.instance:getEpisodeCO(self.viewParam)

	TeachNoteModel.instance:setTeachNoteEnterFight(true, true)
	DungeonFightController.instance:enterFight(config.chapterId, self.viewParam)
end

function TeachNoteDetailView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_5.png"))
	self._simagebg2:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_5_1.png"))
	self._simagebg3:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_5_2.png"))
end

function TeachNoteDetailView:onUpdateParam()
	return
end

function TeachNoteDetailView:onOpen()
	self._descItems = {}

	self:_refreshView()
end

function TeachNoteDetailView:_refreshView()
	local episodeCo = DungeonConfig.instance:getEpisodeCO(self.viewParam)

	self._txtname.text = episodeCo.name
	self._txtnameen.text = episodeCo.name_En

	local lvCo = TeachNoteModel.instance:getTeachNoteInstructionLevelCo(self.viewParam)

	self._simageicon:LoadImage(ResUrl.getTeachNoteImage(lvCo.picRes .. ".png"))

	self._txtnotedesc.text = lvCo.instructionDesc

	if self._descItems then
		for _, v in pairs(self._descItems) do
			v:onDestroyView()
		end
	end

	self._descItems = {}

	local descCos = string.split(TeachNoteConfig.instance:getInstructionLevelCO(lvCo.id).desc, "#")
	local item

	for i = 1, #descCos do
		local child = gohelper.cloneInPlace(self._godescitem)

		gohelper.setActive(child, true)

		item = TeachNoteDescItem.New()

		item:init(child, i, lvCo.id)
		table.insert(self._descItems, item)
	end

	self._txtlearnstart.text = luaLang("teachnoteview_start")
end

function TeachNoteDetailView:onClose()
	return
end

function TeachNoteDetailView:onDestroyView()
	if self._descItems then
		for _, v in pairs(self._descItems) do
			v:onDestroyView()
		end
	end

	self._descItems = {}

	self._simageicon:UnLoadImage()
	self._simagebg:UnLoadImage()
	self._simagebg2:UnLoadImage()
	self._simagebg3:UnLoadImage()
end

return TeachNoteDetailView
