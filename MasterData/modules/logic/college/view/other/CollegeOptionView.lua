-- chunkname: @modules/logic/college/view/other/CollegeOptionView.lua

module("modules.logic.college.view.other.CollegeOptionView", package.seeall)

local CollegeOptionView = class("CollegeOptionView", BaseView)

function CollegeOptionView:onInitView()
	self._txttitle = gohelper.findChildTextMesh(self.viewGO, "root/#txt_title")
	self._simagepic = gohelper.findChildSingleImage(self.viewGO, "root/#simage_pic")
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "root/#scroll_Desc/Viewport/Content/#txt_desc")
	self._gooption = gohelper.findChild(self.viewGO, "root/options/#btn_option")
end

function CollegeOptionView:onOpen()
	self._eventMo = CollegeModel.instance:getSceneMo().eventBox

	self:_refreshUI()
end

function CollegeOptionView:_refreshUI()
	self._eventCo = self._eventMo.co
	self._txttitle.text = self._eventCo.title
	self._txtdesc.text = self._eventCo.body

	self._simagepic:LoadImage(ResUrl.getCollegeSingleBg(self._eventCo.artAsset, "event"))

	local options = string.splitToNumber(self._eventCo.optionIds, "#")

	gohelper.CreateObjList(self, self._createOption, options, nil, self._gooption)
end

function CollegeOptionView:_createOption(obj, data, index)
	local co = lua_college_event_option.configDict[data]

	if not co then
		return
	end

	local gogood = gohelper.findChild(obj, "#go_good")
	local gobad = gohelper.findChild(obj, "#go_bad")
	local txtname = gohelper.findChildTextMesh(obj, "#txt_name")
	local txtnum = gohelper.findChildTextMesh(obj, "#txt_num")
	local btn = gohelper.findButtonWithAudio(obj)

	gohelper.setActive(gogood, co.optionType == 1)
	gohelper.setActive(gobad, co.optionType == 2)

	txtname.text = co.label
	txtnum.text = co.description

	self.addClickCb(self, btn, self._onClickOption, self, index - 1)
end

function CollegeOptionView:_onClickOption(index)
	CollegeRpc.instance:sendCollegeEventOption(self._eventCo.id, index, self._onRecvMsg, self)
end

function CollegeOptionView:_onRecvMsg(cmd, resultCode, msg)
	if resultCode == 0 and not CollegeStoryHelper.instance:isPlayingStory() and self._eventMo.co then
		self:_refreshUI()
	else
		self:closeThis()
	end
end

function CollegeOptionView:onClose()
	CollegeHelper.instance:setViewVisible(self.viewName, false)
end

return CollegeOptionView
