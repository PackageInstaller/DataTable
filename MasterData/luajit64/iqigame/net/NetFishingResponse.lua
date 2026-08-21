-- chunkname: @IQIGame\\Net\\NetFishingResponse.lua

function net_fishing.fishingResult(code, fishId, baitId, rodId)
	FishingModule.FishingResult(fishId, baitId, rodId)
end

function net_fishing.fishingConfirmResult(code, pod)
	FishingModule.FishingConfirmResult(pod)
end

function net_fishing.fishingConfirmResult_delegate(code, pod)
	NetCommController.Responded()

	if code ~= 0 then
		if code == 47002 then
			NoticeModule.ShowNotice(21042041)
		else
			NoticeModule.ShowServerError(code)
		end

		return
	end

	net_fishing.fishingConfirmResult(code, pod)
end

function net_fishing.illegalFishingResult(code, podList)
	FishingModule.IllegalFishingResult(podList)
end

function net_fishing.fishSpecimenResult(code, specimenData)
	FishingModule.FishSpecimenResult(specimenData)
end

function net_fishing.exchangeFishResult(code, podList)
	FishingModule.ExchangeFishResult(podList)
end

function net_fishing.notifyFishSpecimen(newSpecimenList)
	FishingModule.NotifyFishSpecimen(newSpecimenList)
end

function net_fishing.exchangeFishByTypeResult(code, podList)
	FishingModule.ExchangeFishByTypeResult(podList)
end

function net_fishing.automaticFishingResult(code, time)
	FishingModule.AutomaticFishingResult(time)
end

function net_fishing.drawRewardsResult(code, podList)
	FishingModule.DrawRewardsResult(podList)
end

function net_fishing.notifyFishOpen(fishingData)
	FishingModule.NotifyFishOpen(fishingData)
end
