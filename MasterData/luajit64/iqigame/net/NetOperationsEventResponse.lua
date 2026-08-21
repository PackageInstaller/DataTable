-- chunkname: @IQIGame\\Net\\NetOperationsEventResponse.lua

function net_operationsGroupPurchase.groupPurchaseBuyResult(code, list, pod)
	ActiveGroupBuyModule.GroupPurchaseBuyResult(list, pod)
end

function net_operationsEvent.notifyAllEventStatus(list)
	ActiveOperationEventModule.NotifyAllEventStatus(list)
end

function net_operationsEvent.notifyOperationsEventData(pod)
	ActiveOperationEventModule.NotifyOperationEventData(pod)
end

function net_operationsImagePuzzle.imagePuzzleUnlockResult(code, pod)
	ActivePicturePuzzleModule.ImagePuzzleUnlockResult(pod)
end

function net_operationsImagePuzzle.imagePuzzleGetUnlockRewardResult(code, list, pod)
	ActivePicturePuzzleModule.ImagePuzzleGetUnlockRewardResult(list, pod)
end

function net_operationsImagePuzzle.imagePuzzleGetRewardResult(code, list, pod)
	ActivePicturePuzzleModule.ImagePuzzleGetRewardResult(list, pod)
end
