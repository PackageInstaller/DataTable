-- chunkname: @modules/logic/story/view/V3A9StoryScoreCardView.lua

module("modules.logic.story.view.V3A9StoryScoreCardView", package.seeall)

local V3A9StoryScoreCardView = class("V3A9StoryScoreCardView", BaseView)

function V3A9StoryScoreCardView:onInitView()
	self.anim = gohelper.findChildAnim(self.viewGO, "#go_contentroot/#go_layout")
	self.goContent = gohelper.findChild(self.viewGO, "#go_contentroot/#go_layout")
	self.animEvent = self.goContent:GetComponent(typeof(ZProj.AnimationEventWrap))
	self.txtList = {}

	for i = 1, 4 do
		self.txtList[i] = gohelper.findChildText(self.viewGO, string.format("#go_contentroot/#go_layout/go_scoreitem%d/#txt_score", i))
	end
end

function V3A9StoryScoreCardView:addEvents()
	self.animEvent:AddEventListener("change", self.changeScore, self)
	self.animEvent:AddEventListener("close", self.closeView, self)
end

function V3A9StoryScoreCardView:removeEvents()
	self.animEvent:RemoveAllEventListener()
end

function V3A9StoryScoreCardView:onUpdateParam()
	self.data = self.viewParam.data

	self:onUpdateView()
end

function V3A9StoryScoreCardView:onOpen()
	self.data = self.viewParam.data

	self:onUpdateView()
end

function V3A9StoryScoreCardView:onClose()
	return
end

function V3A9StoryScoreCardView:onUpdateView()
	local chapterCo = self.data

	self.curScoreList = string.splitToNumber(chapterCo.navigateLogo, "#")

	local animType = tonumber(chapterCo.navigateChapterEn)

	if animType < StoryEnum.ScoreCardAnimType.dafenban5_change then
		local animName = self:getAnimName(animType)

		self.anim:Play(animName, 0, 0)
	else
		self.anim:SetInteger("Stage", animType)
	end
end

function V3A9StoryScoreCardView:getAnimName(animType)
	for k, v in pairs(StoryEnum.ScoreCardAnimType) do
		if v == animType then
			return k
		end
	end
end

function V3A9StoryScoreCardView:changeScore()
	if not self.curScoreList then
		return
	end

	for i, v in ipairs(self.txtList) do
		v.text = self.curScoreList[i]
	end
end

function V3A9StoryScoreCardView:closeView()
	self:closeThis()
end

function V3A9StoryScoreCardView:onDestroyView()
	return
end

return V3A9StoryScoreCardView
