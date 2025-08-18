-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawCountNoticePanel.lua

local ResDrawCountNoticeClient = require("ClientData/ResDrawCountNoticeClient")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local strClassName = "DrawCountNoticePanel"
local DrawCountNoticePanel = Class(strClassName, UIControls.Panel)

function DrawCountNoticePanel:ctor()
	self:initUI()
end

function DrawCountNoticePanel:initUI()
	self.noticeTxt = UIControls.Label(self, self.mPath .. "/Text")
	self.tipsBtn = UIControls.Button(self, self.mPath .. "/BtnTips")

	self.tipsBtn:addEventClick(self._onClickTips)
end

function DrawCountNoticePanel:_checkRegion()
	if RegionUtils.isJP() or RegionUtils.isKR() then
		return true
	else
		return false
	end
end

function DrawCountNoticePanel:initData(poolId, poolType)
	if not self:_checkRegion() then
		return
	end

	if not ResDrawCountNoticeClient[poolId] then
		self:setVisible(false)

		return
	end

	self.poolId = poolId
	self.poolType = poolType
	self.noticeInfo = ResDrawCountNoticeClient[poolId]

	self:syncRecord()
end

function DrawCountNoticePanel:syncRecord()
	if self.poolId then
		DrawCardUtils.syncDrawRecord(self.poolId)
	end
end

function DrawCountNoticePanel:refreshCountNotice()
	if not self:_checkRegion() then
		return
	end

	if not self.poolId or not self.poolType or not self.noticeInfo then
		return
	end

	local nowCount = self:_getNowCount()

	if not nowCount then
		return
	end

	local nowInfo

	if nowCount == 0 then
		nowInfo = self.noticeInfo[1]
	else
		for i, info in ipairs(self.noticeInfo) do
			if nowCount <= info.count then
				if i > 1 then
					nowInfo = self.noticeInfo[i - 1]

					break
				end

				nowInfo = self.noticeInfo[1]

				break
			end

			if i == #self.noticeInfo then
				nowInfo = info
			end
		end
	end

	if not nowInfo.count_type then
		self:setVisible(false)
	else
		self:setVisible(true)
		self.noticeTxt:setText("")

		self.tipsNo = nowInfo.tips_id

		local content

		if nowInfo.count_type == 1 then
			content = string.gsub(nowInfo.content, "$1", nowCount)
		elseif nowInfo.count_type == 2 then
			local recordList = DrawCardUtils.getDrawRecord(self.poolId)
			local lastOrangeDistance = 0

			for i, record in ipairs(recordList) do
				if record[4] and record[3] >= 5 then
					lastOrangeDistance = i - 1

					break
				end
			end

			content = string.gsub(nowInfo.content, "$1", nowInfo.param - lastOrangeDistance)
		end

		self.noticeTxt:setText(content)
	end
end

function DrawCountNoticePanel:_getNowCount()
	local roleDrawData = CurAvatar.roleDrawData

	if not roleDrawData or not roleDrawData[self.poolType] then
		return
	end

	return roleDrawData[self.poolType].totalDrawCount or 0
end

function DrawCountNoticePanel:_onClickTips(...)
	if self.tipsNo then
		UIManager.getUI("infoNotice", true):showSystemInfo(self.tipsNo)
	end
end

return DrawCountNoticePanel
