-- chunkname: @IQIGame\\Net\\NetOperationsNewCharacterResponse.lua

function net_operationsNewCharacter.newCharacterStoryResult(code)
	ActiveNewCharacterModule.NewCharacterStoryResult()
end

function net_operationsNewCharacter.notifyNewCharacterStoryFinished(eventId, storyId, list)
	ActiveNewCharacterModule.NotifyNewCharacterStoryFinished(eventId, storyId, list)
end

function net_operationsNewCharacter.newCharacterUnlockResult(code, cardList, bingoIdList, showList)
	DollBingoModule.OnReqLottery(cardList, bingoIdList, showList)
end

function net_operationsNewCharacter.bingoLogResult_delegate(code, podList)
	DollBingoModule.OnReqRecord(code, podList)
end
