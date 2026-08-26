-- chunkname: @modules/logic/activity/view/LinkageActivity_Page2.lua

module("modules.logic.activity.view.LinkageActivity_Page2", package.seeall)

local LinkageActivity_Page2 = class("LinkageActivity_Page2", LinkageActivity_PageBase)

function LinkageActivity_Page2:ctor(...)
	LinkageActivity_Page2.super.ctor(self, ...)

	self._rewardItemList = {}
	self._videoItemList = {}
	self._curVideoIndex = false
end

function LinkageActivity_Page2:onDestroyView()
	self._curVideoIndex = false

	GameUtil.onDestroyViewMemberList(self, "_rewardItemList")
	GameUtil.onDestroyViewMemberList(self, "_videoItemList")
	LinkageActivity_Page2.super.onDestroyView(self)
end

function LinkageActivity_Page2:addReward(index, go, clsDefine)
	local item = clsDefine.New({
		parent = self,
		baseViewContainer = self:baseViewContainer()
	})

	item:setIndex(index)
	item:init(go)
	table.insert(self._rewardItemList, item)

	return item
end

function LinkageActivity_Page2:addVideo(index, go, clsDefine)
	local item = clsDefine.New({
		parent = self,
		baseViewContainer = self:baseViewContainer()
	})

	item:setIndex(index)
	item:init(go)
	table.insert(self._videoItemList, item)

	return item
end

function LinkageActivity_Page2:curVideoIndex()
	return self._curVideoIndex
end

function LinkageActivity_Page2:getReward(index)
	return self._rewardItemList[index]
end

function LinkageActivity_Page2:getVideo(index)
	return self._videoItemList[index]
end

function LinkageActivity_Page2:selectedVideo(index)
	if self._curVideoIndex == index then
		return
	end

	local isFirst = self._curVideoIndex == false
	local lastIndex = self._curVideoIndex

	self._curVideoIndex = index

	self:onSelectedVideo(index, lastIndex, isFirst)
end

function LinkageActivity_Page2:onUpdateMO()
	self:_onUpdateMO_rewardList()
	self:_onUpdateMO_videoList()
end

function LinkageActivity_Page2:_onUpdateMO_rewardList()
	local dataList = self:getTempDataList()

	if dataList then
		for i, item in ipairs(self._rewardItemList) do
			item:onUpdateMO(dataList[i])
		end
	end
end

function LinkageActivity_Page2:_onUpdateMO_videoList()
	for i, item in ipairs(self._videoItemList) do
		local videoName = self:getLinkageActivityCO_res_video(i)
		local data = {
			videoName = videoName
		}

		item:onUpdateMO(data)
	end
end

function LinkageActivity_Page2:onSelectedVideo(index, lastIndex, isFirst)
	assert(false, "please override this function")
end

function LinkageActivity_Page2:onPostSelectedPage(curPage, lastPage)
	if self == curPage then
		self:_onUpdateMO_videoList()
	end
end

return LinkageActivity_Page2
