-- chunkname: @modules/logic/story/view/dialogEffs/StoryDialogEffsMagic.lua

module("modules.logic.story.view.dialogEffs.StoryDialogEffsMagic", package.seeall)

local StoryDialogEffsMagic = class("StoryDialogEffsMagic", StoryDialogEffsBase)

function StoryDialogEffsMagic:ctor()
	StoryDialogEffsMagic.super.ctor(self)
end

function StoryDialogEffsMagic:init(conGo)
	StoryDialogEffsMagic.super.init(self)

	self._gocontent = conGo
	self._gomagiccontent = gohelper.findChild(self._gocontent, "go_magiccontent")
	self._txtcommon = gohelper.findChildText(self._gomagiccontent, "txt_common")
	self._gocommonfireroot = gohelper.findChild(self._gomagiccontent, "txt_common/go_firework")
	self._txtreshape = gohelper.findChildText(self._gomagiccontent, "txt_reshape")
	self._goreshapefireroot = gohelper.findChild(self._gomagiccontent, "txt_reshape/go_firework")
	self._txtsilver = gohelper.findChildText(self._gomagiccontent, "txt_silver")
	self._gosilverfireroot = gohelper.findChild(self._gomagiccontent, "txt_silver/go_firework")
	self._gosand = gohelper.findChild(self._gomagiccontent, "txt_sand")
	self._gogoldline = gohelper.findChild(self._gomagiccontent, "txt_goldline")
	self._txtxran = gohelper.findChildText(self._gomagiccontent, "txt_xran")
	self._goxranfireroot = gohelper.findChild(self._gomagiccontent, "txt_xran/go_firework")
	self._commonMagicFirePath = ResUrl.getEffect("story/story_magicfont_particle")
	self._reshapeMagicFirePath = ResUrl.getEffect("story/story_magicfont_particle_dark")
	self._silverMagicFirePath = ResUrl.getSceneUIPrefab("story", "story_magicfont_particle_silver")
	self._xranMagicFirePath = ResUrl.getSceneUIPrefab("story", "story_magicfont_particle_feather")
	self._magicTab = {
		gos = {
			[StoryEnum.ConversationEffectType.CommonMagic] = self._txtcommon.gameObject,
			[StoryEnum.ConversationEffectType.ReshapeMagic] = self._txtreshape.gameObject,
			[StoryEnum.ConversationEffectType.SilverMagic] = self._txtsilver.gameObject,
			[StoryEnum.ConversationEffectType.SandMagic] = self._gosand,
			[StoryEnum.ConversationEffectType.GoldlineMagic] = self._gogoldline,
			[StoryEnum.ConversationEffectType.XranMagic] = self._txtxran
		},
		txts = {
			[StoryEnum.ConversationEffectType.CommonMagic] = self._txtcommon,
			[StoryEnum.ConversationEffectType.ReshapeMagic] = self._txtreshape,
			[StoryEnum.ConversationEffectType.SilverMagic] = self._txtsilver,
			[StoryEnum.ConversationEffectType.XranMagic] = self._txtxran
		},
		paths = {
			[StoryEnum.ConversationEffectType.CommonMagic] = self._commonMagicFirePath,
			[StoryEnum.ConversationEffectType.ReshapeMagic] = self._reshapeMagicFirePath,
			[StoryEnum.ConversationEffectType.SilverMagic] = self._silverMagicFirePath,
			[StoryEnum.ConversationEffectType.XranMagic] = self._xranMagicFirePath
		},
		fireroots = {
			[StoryEnum.ConversationEffectType.CommonMagic] = self._gocommonfireroot,
			[StoryEnum.ConversationEffectType.ReshapeMagic] = self._goreshapefireroot,
			[StoryEnum.ConversationEffectType.SilverMagic] = self._gosilverfireroot,
			[StoryEnum.ConversationEffectType.XranMagic] = self._goxranfireroot
		}
	}

	for _, txt in pairs(self._magicTab.txts) do
		txt.text = ""
	end

	for _, path in pairs(self._magicTab.paths) do
		table.insert(self._resList, path)
	end
end

function StoryDialogEffsMagic:start(stepCo, txt, callback, callbackObj)
	if not stepCo then
		return
	end

	self:_killTween()
	StoryDialogEffsMagic.super.start(self, stepCo)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj
	self._stepCo = stepCo

	for _, go in pairs(self._magicTab.gos) do
		gohelper.setActive(go, false)
	end

	self._initTxt = txt
	self._txt = StoryTool.filterSpTag(txt)

	local isSpMagicType = StoryModel.instance:isSpMagicType(self._stepCo)

	if not isSpMagicType then
		self._magicTab.txts[self._stepCo.conversation.effType].text = self._txt
	else
		gohelper.setActive(self._magicTab.gos[self._stepCo.conversation.effType], true)
		GameUtil.setActiveUIBlock("spMagicShow", true, false)
		TaskDispatcher.runDelay(self._magicConFinished, self, 2)

		return
	end

	self:loadRes()
end

function StoryDialogEffsMagic:onLoadFinished()
	StoryDialogEffsMagic.super.onLoadFinished(self)
	StoryTool.enablePostProcess(true)

	for index, path in pairs(self._magicTab.paths) do
		self._magicTab.gofires = self._magicTab.gofires or {}

		if not self._magicTab.gofires[index] then
			local assetItem = self._loader:getAssetItem(path)

			self._magicTab.gofires[index] = gohelper.clone(assetItem:GetResource(path), self._magicTab.fireroots[index])
		end

		self._magicTab.anims = self._magicTab.anims or {}
		self._magicTab.anims[index] = self._magicTab.gofires[index]:GetComponent(typeof(UnityEngine.Animator))
	end

	self:_startEffectShow()
end

function StoryDialogEffsMagic:_startEffectShow()
	if not self._stepCo then
		return
	end

	local x, y, _ = transformhelper.getLocalPos(self._magicTab.txts[self._stepCo.conversation.effType].transform)

	transformhelper.setLocalPos(self._magicTab.txts[self._stepCo.conversation.effType].transform, x, y, 1)

	local delay = self:_getMagicWordShowTime(self._initTxt)

	self._magicConTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, delay, self._magicConUpdate, self._magicConFinished, self, nil, EaseType.Linear)

	if not self._magicTab.anims then
		return
	end

	self._magicTab.anims[self._stepCo.conversation.effType]:Play("story_magicfont_particle")

	for index, goroot in pairs(self._magicTab.fireroots) do
		gohelper.setActive(goroot, self._stepCo.conversation.effType == index)
	end

	for index, go in pairs(self._magicTab.gos) do
		gohelper.setActive(go, self._stepCo.conversation.effType == index)
	end

	if delay > 0 then
		for _, anim in pairs(self._magicTab.anims) do
			anim.speed = 1 / delay
		end
	end
end

function StoryDialogEffsMagic:_getMagicWordShowTime(txt)
	local result = string.gsub(txt, "%%", "--------")

	result = string.gsub(result, "%&", "--------")

	local wordSize = LuaUtil.getCharNum(result)
	local speed = 0.1

	if wordSize < 30 then
		speed = 0.2
	end

	if wordSize < 15 then
		speed = 0.5
	end

	if result and string.find(result, "<speed=%d[%d.]*>") then
		local speedTxt = string.sub(result, string.find(result, "<speed=%d[%d.]*>"))

		speed = speedTxt and tonumber(string.match(speedTxt, "%d[%d.]*")) or 1
	end

	return speed * wordSize
end

function StoryDialogEffsMagic:_magicConUpdate(value)
	if not self._stepCo then
		return
	end

	if not self._magicTab then
		return
	end

	local txtTrans = self._magicTab.txts[self._stepCo.conversation.effType].gameObject.transform

	if not txtTrans then
		return
	end

	local width = recthelper.getWidth(txtTrans)
	local maxMagicShowWidth = 2215

	if value > (width + 100) / maxMagicShowWidth and width > 1 then
		self:_killTween()
		self:_magicConFinished()

		return
	end

	local conWidth = 0.5 * maxMagicShowWidth
	local x, y, _ = transformhelper.getLocalPos(txtTrans)
	local screenWidth, screenheight = UnityEngine.Screen.width, UnityEngine.Screen.height
	local lockScreenWidth, lockScreenHeight = 1920, 1080
	local totalWidth = lockScreenWidth * (lockScreenHeight * screenWidth / (lockScreenWidth * screenheight))
	local contetnPosX = transformhelper.getLocalPos(self._gocontent.transform)
	local posX = transformhelper.getLocalPos(txtTrans.gameObject.transform)
	local startPosX = 0.5 * (lockScreenHeight * screenWidth / screenheight) + posX + contetnPosX
	local rate = (startPosX + value * (conWidth + 10)) / totalWidth

	transformhelper.setLocalPos(txtTrans, x, y, 1 - rate)

	if not self._magicTab.gofires then
		return
	end

	local gofireTrans = self._magicTab.gofires[self._stepCo.conversation.effType].transform
	local screenposy = recthelper.uiPosToScreenPos(txtTrans, ViewMgr.instance:getUICanvas()).y
	local psPos = recthelper.screenPosToAnchorPos(Vector2(rate * screenWidth, screenposy), self._magicTab.fireroots[self._stepCo.conversation.effType].transform)

	transformhelper.setLocalPos(gofireTrans, psPos.x, psPos.y, 0)
end

function StoryDialogEffsMagic:_magicConFinished()
	GameUtil.setActiveUIBlock("spMagicShow", false)

	for _, txt in pairs(self._magicTab.txts) do
		local x, y, _ = transformhelper.getLocalPos(txt.gameObject.transform)

		transformhelper.setLocalPos(txt.transform, x, y, 0)
	end

	for _, fireroot in pairs(self._magicTab.fireroots) do
		gohelper.setActive(fireroot, false)
	end

	if self._magicTab.anims then
		for _, anim in pairs(self._magicTab.anims) do
			anim.speed = 1
		end
	end

	if self._finishedCallback then
		self._finishedCallback(self._finishedCallbackObj)
	end
end

function StoryDialogEffsMagic:showEff(show)
	gohelper.setActive(self._gomagiccontent, show)

	if not show then
		for _, txt in pairs(self._magicTab.txts) do
			local x, y, _ = transformhelper.getLocalPos(txt.gameObject.transform)

			transformhelper.setLocalPos(txt.transform, x, y, 1)

			txt.text = ""
		end

		self:_killTween()
	end
end

function StoryDialogEffsMagic:_killTween()
	if self._magicConTweenId then
		ZProj.TweenHelper.KillById(self._magicConTweenId)

		self._magicConTweenId = nil
	end
end

function StoryDialogEffsMagic:destroy()
	GameUtil.setActiveUIBlock("spMagicShow", false)
	StoryDialogEffsMagic.super.destroy(self)
	TaskDispatcher.cancelTask(self._magicConFinished, self)

	if self._magicTab and self._magicTab.anims then
		for _, anim in pairs(self._magicTab.anims) do
			anim.speed = 1
		end
	end

	self:_killTween()

	self._finishedCallback = nil
	self._finishedCallbackObj = nil
end

return StoryDialogEffsMagic
