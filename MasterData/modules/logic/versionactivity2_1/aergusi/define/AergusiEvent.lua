-- chunkname: @modules/logic/versionactivity2_1/aergusi/define/AergusiEvent.lua

module("modules.logic.versionactivity2_1.aergusi.define.AergusiEvent", package.seeall)

local AergusiEvent = _M

AergusiEvent.ActInfoUpdate = 1001
AergusiEvent.StartEpisode = 1002
AergusiEvent.StartOperation = 1003
AergusiEvent.EnterEpisode = 1004
AergusiEvent.EvidenceFinished = 1005
AergusiEvent.QuitEvidence = 1006
AergusiEvent.RestartEvidence = 1007
AergusiEvent.EvidenceError = 1008
AergusiEvent.OnStartDialogGroup = 2000
AergusiEvent.OnRefuteStartGroup = 2001
AergusiEvent.OnStartAutoBubbleDialog = 2002
AergusiEvent.OnStartDialogNextStep = 2003
AergusiEvent.OnShowDialogGroupFinished = 2004
AergusiEvent.OnDialogDoubtClick = 2005
AergusiEvent.OnDialogAskSuccess = 2006
AergusiEvent.OnDialogAskFail = 2007
AergusiEvent.OnDialogNotKeyAsk = 2008
AergusiEvent.OnStartErrorBubbleDialog = 2009
AergusiEvent.OneClickClaimReward = 3001
AergusiEvent.OnPlayMergeSuccess = 3002
AergusiEvent.OnPlayClueItemNewMerge = 3003
AergusiEvent.OnPlayPromptTip = 3004
AergusiEvent.OnClickClueItem = 4001
AergusiEvent.OnClickCloseMergeClue = 4002
AergusiEvent.OnClickStartMergeClue = 4003
AergusiEvent.OnClickClueMergeItem = 4004
AergusiEvent.OnClickClueMergeSelect = 4005
AergusiEvent.OnClueReadUpdate = 4006
AergusiEvent.OnClickShowResultTip = 5001
AergusiEvent.OnClickEpisodeClueBtn = 5002
AergusiEvent.OnGuideShowClueMerge = 6001
AergusiEvent.OnGuideClueMergeSuccess = 6002
AergusiEvent.OnGuideEnterInteractRefutation = 6003
AergusiEvent.OnGuideEnterInteractProbe = 6004
AergusiEvent.OnGuideShowTask = 6005
AergusiEvent.OnGuideSelectAdam = 6006

return AergusiEvent
