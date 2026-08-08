local CheckUpdateWnd = require "CheckUpdateWnd_Generate"

local CheckUpdateWndStr = {
	getVersion = "正在检测版本...",
	waitUpdate = "等待更新...",
	downloading = "更新中...",
	copying = "正在解压...",		--拷贝
	updateEnd = "更新完成",			--删除
}

function CheckUpdateWnd:InitLogic(data)
	self.bMustUpdate = true
end

function CheckUpdateWnd:InitData(data)
	self.progress:SetActive(false)
	self.content1:SetActive(false)
	self.content2:SetActive(true)

	self.checkState.text.text = CheckUpdateWndStr.getVersion
end

function CheckUpdateWnd:UpdatePackage(callBack)
	UIMgr:popUI("CheckUpdateMsgBox", { updatePackage = true, callBack = callBack})
	self.checkState.text.text = CheckUpdateWndStr.waitUpdate
end

function CheckUpdateWnd:MustUpdate()
	self.bMustUpdate = true
end

function CheckUpdateWnd:OptinalUpdate()
	self.bMustUpdate = false
end

function CheckUpdateWnd:SetUpdateFiles(updateList, deleteList, callBack)
	self.updateListCount = #updateList
	self.copyListCount = self.updateListCount
	self.deleteListCount = #deleteList
	self.updateSize = 0
	for k,v_data in pairs(updateList) do
		self.updateSize = self.updateSize + v_data.size
	end
	if self.updateSize >= 1024*1024*1024 then
		--GB
		self.updateSize = string.format("%0.1fGB", self.updateSize/(1024*1024*1024))
	elseif self.updateSize >= 1024*1024 then
		--MB
		self.updateSize = string.format("%0.1fMB", self.updateSize/(1024*1024))
	elseif self.updateSize >= 1024 then
		--KB
		self.updateSize = string.format("%0.1fKB", self.updateSize/1024)
	else
		--B
		self.updateSize = self.updateSize .. "B"
	end
	UIMgr:popUI("CheckUpdateMsgBox", { update = true, size = self.updateSize, bMust = self.bMustUpdate, callBack = callBack})
	self.checkState.text.text = CheckUpdateWndStr.waitUpdate
end

function CheckUpdateWnd:StartDownLoad(fileIndex)
	self.checkState.text.text = CheckUpdateWndStr.downloading
	self.progress:SetActive(true)
	self.progress.slider.value = 0
	self.content1:SetActive(true)
	self.progressText.text.text = string.format("%d/%d", fileIndex, self.updateListCount)
end

function CheckUpdateWnd:DownLoading(len, total)
	self.progress.slider.value = len/total
end

function CheckUpdateWnd:StartCopy()
	self.checkState.text.text = CheckUpdateWndStr.copying
	self.progress:SetActive(true)
	self.progress.slider.value = 0
	self.content1:SetActive(true)
	self.copyedNum = 0
	self.progressText.text.text = string.format("%d/%d", self.copyedNum, self.copyListCount)
end

function CheckUpdateWnd:Copyed(fileName)
	self.copyedNum = self.copyedNum + 1
	self.progress.slider.value = self.copyedNum/self.copyListCount
	self.progressText.text.text = string.format("%d/%d", self.copyedNum, self.copyListCount)
end

function CheckUpdateWnd:StartDelete()
	self.checkState.text.text = CheckUpdateWndStr.updateEnd
	self.progress.slider.value = 1/(self.deleteListCount + 1)
	self.content1:SetActive(false)
	self.deletedNum = 0
end

function CheckUpdateWnd:Deleted(fileName)
	self.deletedNum = self.deletedNum + 1
	self.progress.slider.value = (1+self.deletedNum)/(self.deleteListCount + 1)
end

--function CheckUpdateWnd:StartCreating(time)
--
--end

--function CheckUpdateWnd:StartEnter(time)
--
--end

--function CheckUpdateWnd:StartRemoving(time)
--
--end

--function CheckUpdateWnd:StartExit(time)
--
--end

function CheckUpdateWnd:OnOpen(data, initiative)
	if initiative then
		self:InitData(data)
	end
end

--function CheckUpdateWnd:OnClose(initiative)
--
--end

--function CheckUpdateWnd:OnDestroy()
--
--end

--function CheckUpdateWnd:OnRefresh(data)
--
--end

--[[
/BG/progressNode/Progress onValueChanged 
--]]
function CheckUpdateWnd:progress_Slider_onValueChanged(progress,value)

end

return CheckUpdateWnd
