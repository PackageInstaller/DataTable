-- chunkname: @modules/logic/notice/view/NoticeContentItemWrap.lua

module("modules.logic.notice.view.NoticeContentItemWrap", package.seeall)

local NoticeContentItemWrap = class("NoticeContentItemWrap", MixScrollCell)

NoticeContentItemWrap.Comp2TypeDict = {
	[NoticeTxtTopTitleItem] = {
		NoticeContentType.TxtTopTitle
	},
	[NoticeTxtContentItem] = {
		NoticeContentType.TxtContent
	},
	[NoticeImgItem] = {
		NoticeContentType.ImgInner,
		NoticeContentType.ImgTitle
	}
}

function NoticeContentItemWrap:init(go)
	self.compList = {}

	for compCls, types in pairs(NoticeContentItemWrap.Comp2TypeDict) do
		local comp = compCls.New()

		comp:init(go, types)
		table.insert(self.compList, comp)
	end
end

function NoticeContentItemWrap:addEventListeners()
	for _, comp in ipairs(self.compList) do
		comp:addEventListeners()
	end
end

function NoticeContentItemWrap:removeEventListeners()
	for _, comp in ipairs(self.compList) do
		comp:removeEventListeners()
	end
end

function NoticeContentItemWrap:onUpdateMO(mo)
	for _, comp in ipairs(self.compList) do
		comp:onUpdateMO(mo)
	end
end

function NoticeContentItemWrap:onDestroy()
	for _, comp in ipairs(self.compList) do
		comp:onDestroy()
	end

	self.compList = nil
end

return NoticeContentItemWrap
