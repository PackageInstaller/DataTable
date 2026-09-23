QuestionnaireProto = {}

function QuestionnaireProto:GetInfo(_cb)
    self.GetInfoCB = _cb
    local proto = {"QuestionnaireProto:GetInfo"}
    NetMgr.net:Send(proto)
end
function QuestionnaireProto:GetInfoRet(proto)
    QuestionnaireMgr:GetInfoRet(proto.infos)
    if (self.GetInfoCB) then
        self.GetInfoCB()
    end
    self.GetInfoCB = nil
end

function QuestionnaireProto:GetReward(_id, _cb)
    self.GetRewardCB = _cb
    local proto = {"QuestionnaireProto:GetReward", {
        id = _id
    }}
    NetMgr.net:Send(proto)
end
function QuestionnaireProto:GetRewardRet(proto)
    QuestionnaireMgr:GetRewardRet(proto.id)
    if (self.GetRewardCB) then
        self.GetRewardCB()
    end
    self.GetRewardCB = nil
end

function QuestionnaireProto:Jump(_id, _cb)
    self.JumpCB = _cb
    local proto = {"QuestionnaireProto:Jump", {
        id = _id
    }}
    NetMgr.net:Send(proto)
end
function QuestionnaireProto:JumpRet(proto)
    QuestionnaireMgr:JumpRet(proto.id)
    if (self.JumpCB) then
        self.JumpCB()
    end
    self.JumpCB = nil
end
