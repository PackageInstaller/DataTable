-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyArchivePosCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextEmpty, MonsterAcademySLDataUIApi:GetString("TextEmpty"))
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.archiveData = data

	UGUIUtil.SetText(self.TextTitle, MonsterAcademySLDataUIApi:GetString("TextArchiveTitle", self.archiveData.index, self.archiveData.type))

	if self.archiveData.saveDataPod then
		self.ImgBg:SetActive(true)
		UGUIUtil.SetText(self.TextDay, MonsterAcademySLDataUIApi:GetString("TextDay", self.archiveData.saveDataPod.day))
		UGUIUtil.SetText(self.TextTime, getDateTimeText(self.archiveData.saveDataPod.saveTime))

		local week = 1

		for i, v in pairsCfg(CfgGalgameMonsterTimeTable) do
			if v.Group == MonsterAcademyModule.GlobalCid and v.DayNum == self.archiveData.saveDataPod.day then
				week = v.Week

				break
			end
		end

		local path = MonsterAcademySLDataUIApi:GetString("ImgBGPath", week)

		AssetUtil.LoadImage(self, path, self.ImgBg:GetComponent("Image"))
		self.Empty:SetActive(false)
		self.Have:SetActive(true)
	else
		self.Empty:SetActive(true)
		self.Have:SetActive(false)
		self.ImgBg:SetActive(false)
	end
end

function m:SetSelect(top)
	self.ImgSelect:SetActive(top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
