-- chunkname: @modules/logic/story/view/heropreview/StoryHeroPreview.lua

module("modules.logic.story.view.heropreview.StoryHeroPreview", package.seeall)

local StoryHeroPreview = class("StoryHeroPreview", BaseView)

function StoryHeroPreview:onInitView()
	self._goroot = gohelper.findChild(self.viewGO, "#go_root")
	self._goviewnode = gohelper.findChild(self.viewGO, "#go_root/#go_viewnode")
	self._gotopitems = gohelper.findChild(self.viewGO, "#go_topitems")
	self._gosearch = gohelper.findChild(self.viewGO, "#go_topitems/#go_search")
	self._btnclear = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topitems/#go_search/#btn_clear")
	self._txtsearch = gohelper.findChildText(self.viewGO, "#go_topitems/#go_search/#btn_clear/#txt_search")
	self._inputsearch = gohelper.findChildTextMeshInputField(self.viewGO, "#go_topitems/#go_search/#input_search")
	self._gotype = gohelper.findChild(self.viewGO, "#go_topitems/#go_type")
	self._txttype = gohelper.findChildText(self.viewGO, "#go_topitems/#go_type/Image/#txt_type")
	self._gopath = gohelper.findChild(self.viewGO, "#go_topitems/#go_path")
	self._txtpath = gohelper.findChildText(self.viewGO, "#go_topitems/#go_path/Image/#txt_path")
	self._gobody = gohelper.findChild(self.viewGO, "#go_topitems/#go_body")
	self._txtbody = gohelper.findChildText(self.viewGO, "#go_topitems/#go_body/Image/#txt_body")
	self._goface = gohelper.findChild(self.viewGO, "#go_topitems/#go_face")
	self._txtface = gohelper.findChildText(self.viewGO, "#go_topitems/#go_face/Image/#txt_face")
	self._gotalk = gohelper.findChild(self.viewGO, "#go_topitems/#go_talk")
	self._txttalk = gohelper.findChildText(self.viewGO, "#go_topitems/#go_talk/Image/#txt_talk")
	self._godir = gohelper.findChild(self.viewGO, "#go_topitems/#go_dir")
	self._txtdir = gohelper.findChildText(self.viewGO, "#go_topitems/#go_dir/Image/#txt_dir")
	self._btnarrow = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topitems/#btn_arrow")
	self._goup = gohelper.findChild(self.viewGO, "#go_topitems/#btn_arrow/#go_up")
	self._godown = gohelper.findChild(self.viewGO, "#go_topitems/#btn_arrow/#go_down")
	self._toggleoption = gohelper.findChildToggle(self.viewGO, "#go_topitems/#toggle_option")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topitems/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoryHeroPreview:addEvents()
	self._btnclear:AddClickListener(self._btnclearOnClick, self)
	self._btnarrow:AddClickListener(self._btnarrowOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function StoryHeroPreview:removeEvents()
	self._btnclear:RemoveClickListener()
	self._btnarrow:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function StoryHeroPreview:_btnclearOnClick()
	self._inputsearch:SetText("")
	StoryHeroPreviewModel.instance:setFilterTxt("")
	self:_setViewDropItems()
end

function StoryHeroPreview:_btncloseOnClick()
	self:closeThis()
end

function StoryHeroPreview:_btnarrowOnClick()
	self._showNode = not self._showNode

	self:_refreshUI()
end

function StoryHeroPreview:_editableInitView()
	self._droptype = gohelper.findChildDropdown(self.viewGO, "#go_topitems/#go_type/#drop_type")
	self._droppath = gohelper.findChildDropdown(self.viewGO, "#go_topitems/#go_path/#drop_path")
	self._dropbody = gohelper.findChildDropdown(self.viewGO, "#go_topitems/#go_body/#drop_body")
	self._dropface = gohelper.findChildDropdown(self.viewGO, "#go_topitems/#go_face/#drop_face")
	self._droptalk = gohelper.findChildDropdown(self.viewGO, "#go_topitems/#go_talk/#drop_talk")
	self._dropdir = gohelper.findChildDropdown(self.viewGO, "#go_topitems/#go_dir/#drop_dir")
	self._txttoggle = gohelper.findChildText(self.viewGO, "#go_topitems/#toggle_option/Label")

	self:_addSelfEvents()
end

function StoryHeroPreview:_addSelfEvents()
	self._inputsearch:AddOnValueChanged(self._onSearchInputValueChanged, self)
	self._droptype:AddOnValueChanged(self._onTypeValueChanged, self)
	self._droppath:AddOnValueChanged(self._onPathValueChanged, self)
	self._dropbody:AddOnValueChanged(self._onBodyValueChanged, self)
	self._dropface:AddOnValueChanged(self._onFaceValueChanged, self)
	self._droptalk:AddOnValueChanged(self._onTalkValueChanged, self)
	self._dropdir:AddOnValueChanged(self._onDirValueChanged, self)
	self._toggleoption:AddOnValueChanged(self._ontoggleOptionOnClick, self)
end

function StoryHeroPreview:_removeSelfEvents()
	self._inputsearch:RemoveOnValueChanged()
	self._droptype:RemoveOnValueChanged()
	self._droppath:RemoveOnValueChanged()
	self._dropbody:RemoveOnValueChanged()
	self._dropface:RemoveOnValueChanged()
	self._droptalk:RemoveOnValueChanged()
	self._dropdir:RemoveOnValueChanged()
	self._toggleoption:RemoveOnValueChanged()
end

function StoryHeroPreview:_onSearchInputValueChanged()
	local txt = self._inputsearch:GetText()

	StoryHeroPreviewModel.instance:setFilterTxt(txt)

	self._curPathIndex = 0

	self:_setDropPath()
	self:_setHeroAnimDropItem()
	self:_refresh()
end

function StoryHeroPreview:_onTypeValueChanged(index)
	local heroType = StoryHeroPreviewModel.instance:getCurHeroType()

	if index == heroType then
		return
	end

	StoryHeroPreviewModel.instance:setCurHeroType(index)

	self._curPathIndex = 0
	self._curBodyIndex = 0
	self._curFaceIndex = 0
	self._curTalkIndex = 0

	self:_setViewDropItems()
	self:_refresh()
end

function StoryHeroPreview:_onPathValueChanged(index)
	if self._curPathIndex == index then
		return
	end

	self._curPathIndex = index
	self._curBodyIndex = 0
	self._curFaceIndex = 0
	self._curTalkIndex = 0

	self:_refresh()
end

function StoryHeroPreview:_onBodyValueChanged(index)
	if self._curBodyIndex == index then
		return
	end

	self._curBodyIndex = index

	self:_playAnim()
end

function StoryHeroPreview:_onFaceValueChanged(index)
	if self._curFaceIndex == index then
		return
	end

	self._curFaceIndex = index

	self:_playAnim()
end

function StoryHeroPreview:_onTalkValueChanged(index)
	if self._curTalkIndex == index then
		return
	end

	self._curTalkIndex = index

	self:_playAnim()
end

function StoryHeroPreview:_onDirValueChanged(index)
	local curDir = StoryHeroPreviewModel.instance:getCurDir()

	if curDir == index then
		return
	end

	StoryHeroPreviewModel.instance:setCurDir(index)
	self:_setDropDir()
end

function StoryHeroPreview:_ontoggleOptionOnClick(param, isOn)
	self._showHero = isOn

	self:_refresh()
end

function StoryHeroPreview:onUpdateParam()
	return
end

function StoryHeroPreview:onOpen()
	self:_initData()
	self:_initUI()
	self:_setViewDropItems()
	self:_refresh()
end

function StoryHeroPreview:_initData()
	StoryHeroPreviewModel.instance:initData()

	self._showNode = true
	self._showHero = true
	self._curPathIndex = 0
	self._curBodyIndex = 0
	self._curFaceIndex = 0
	self._curTalkIndex = 0
	self._curHeroIndex = 0
end

function StoryHeroPreview:_initUI()
	self._txtsearch.text = "Clear"
	self._txttype.text = "Sp/L2d"
	self._txtpath.text = "Path"
	self._txtbody.text = "BodyAnim"
	self._txtface.text = "FaceAnim"
	self._txttalk.text = "MouthAnim"
	self._txtdir.text = "Direction"

	if not self._heroNode then
		self._heroNode = StoryHeroNode.New()

		self._heroNode:init(self._goviewnode)
	end
end

function StoryHeroPreview:_setViewDropItems()
	self:_setDropType()
	self:_setDropPath()
end

function StoryHeroPreview:_setDropType()
	return
end

function StoryHeroPreview:_setDropPath()
	local options = self:_getFilterPathOptions()

	self._droppath:ClearOptions()
	self._droppath:AddOptions(options)
end

function StoryHeroPreview:_refresh()
	self:_refreshUI()
	self:_refreshHero()
end

function StoryHeroPreview:_refreshUI()
	local posY = self._showNode and 0 or 100

	self._tweenId = ZProj.TweenHelper.DOAnchorPosY(self._gotopitems.transform, posY, 0.2)

	gohelper.setActive(self._goup, self._showNode)
	gohelper.setActive(self._godown, not self._showNode)
	gohelper.setActive(self._goroot, self._showHero)

	self._toggleoption.isOn = self._showHero
	self._txttoggle.text = self._showHero and "show" or "hide"
end

function StoryHeroPreview:_refreshHero()
	if not self._showHero then
		return
	end

	local heroType = StoryHeroPreviewModel.instance:getCurHeroType()
	local heroList = StoryHeroPreviewModel.instance:getAllHeroListByType(heroType)
	local heroCo = heroList[self._curPathIndex + 1]

	if not heroCo then
		return
	end

	if self._curHeroCo == heroCo then
		return
	end

	self:_clearHero()

	self._curHeroCo = heroCo

	self:_playHeroAnim()
end

function StoryHeroPreview:_clearHero()
	if self._heroNode then
		self._heroNode:clearHero()
	end
end

function StoryHeroPreview:_getFilterPathOptions()
	local options = {}
	local pathList = StoryHeroPreviewModel.instance:getAllPathListByType()

	for _, path in ipairs(pathList) do
		local fileName = string.match(path, "([^/]*)$")
		local option = string.gsub(fileName, ".prefab", "")

		table.insert(options, option)
	end

	return options
end

function StoryHeroPreview:_playHeroAnim()
	local pathList = StoryHeroPreviewModel.instance:getAllPathListByType()

	if #pathList <= 0 then
		return
	end

	local path = pathList[self._curPathIndex + 1]

	if not path then
		return
	end

	if self._heroNode then
		self._heroNode:load(self._curHeroCo, path, self._onStartPlayHeroAnim, self)
	end
end

function StoryHeroPreview:_onStartPlayHeroAnim(heroGo)
	self._heroGo = heroGo

	gohelper.setActive(self._goviewnode, false)
	TaskDispatcher.runDelay(self._setHeroAnimDropItem, self, 0.01)
end

function StoryHeroPreview:_setHeroAnimDropItem()
	gohelper.setActive(self._goviewnode, true)
	self:_setDropBody()
	self:_setDropFace()
	self:_setDropTalk()
	self:_setDropDir()
end

function StoryHeroPreview:_getFilterAnims(filterTxt)
	if self._heroNode then
		local targetAnims = {}
		local animations = self._heroNode:getAnimations()

		if animations then
			for _, anim in pairs(animations) do
				if string.match(anim, filterTxt) then
					table.insert(targetAnims, anim)
				end
			end
		end

		return targetAnims
	end

	return {}
end

function StoryHeroPreview:_setDropBody()
	if not self._heroGo then
		return
	end

	local anims = self:_getFilterAnims("b_")

	self._dropbody:ClearOptions()
	self._dropbody:AddOptions(anims)
end

function StoryHeroPreview:_setDropFace()
	if not self._heroGo then
		return
	end

	local anims = self:_getFilterAnims("e_")

	self._dropface:ClearOptions()
	self._dropface:AddOptions(anims)
end

function StoryHeroPreview:_setDropTalk()
	if not self._heroGo then
		return
	end

	local anims = self:_getFilterAnims("t_")

	self._droptalk:ClearOptions()
	self._droptalk:AddOptions(anims)
end

function StoryHeroPreview:_setDropDir()
	if not self._heroGo then
		return
	end

	if self._heroNode then
		local dir = StoryHeroPreviewModel.instance:getCurDir()

		self._heroNode:setDir(dir)
	end
end

function StoryHeroPreview:_playAnim()
	if not self._showHero then
		return
	end

	local co = {}
	local banims = self:_getFilterAnims("b_")

	co.motion = #banims > 0 and string.gsub(banims[self._curBodyIndex + 1], "b_", "") .. "#0#999" or nil

	local tanims = self:_getFilterAnims("t_")

	co.mouth = #tanims > 0 and string.gsub(tanims[self._curTalkIndex + 1], "t_", "") .. "#0#999" or nil

	local fanims = self:_getFilterAnims("e_")

	co.face = #fanims > 0 and string.gsub(fanims[self._curFaceIndex + 1], "e_", "") .. "#0#999" or nil

	if self._heroNode then
		self._heroNode:playAnim(co)
	end
end

function StoryHeroPreview:_setDir()
	if not self._heroGo then
		return
	end

	local heroList = self:_getHeroList()
	local heroCo = heroList[self._curPathIndex + 1]

	if not heroCo then
		return
	end

	transformhelper.setLocalPos(self._heroGo.transform, heroCo.heroPos[1], heroCo.heroPos[2], 0)
	transformhelper.setLocalScale(self._heroGo.transform, heroCo.heroScale, heroCo.heroScale, 1)
end

function StoryHeroPreview:onClose()
	return
end

function StoryHeroPreview:onDestroyView()
	self:_removeSelfEvents()
end

return StoryHeroPreview
