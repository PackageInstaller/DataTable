local M = {}

function M.CalcWinScore(DT, logger, selfUid, pvpMatchData)
  local selfPlayer, otherPlayer, otherUid
  for uid, playerInfo in pairs(pvpMatchData) do
    if uid == selfUid then
      selfPlayer = playerInfo
    else
      otherPlayer = playerInfo
      otherUid = uid
    end
  end
  local baseScore = M.CalcScoreBase(DT, selfPlayer, otherPlayer)
  local diffCoef = M.CalcScoreDiffCoef(DT, selfPlayer, otherPlayer)
  local highScorePlayer = selfPlayer.score >= otherPlayer.score and selfPlayer or otherPlayer
  local score
  if highScorePlayer.uid == selfUid then
    score = math.ceil(baseScore * diffCoef)
  else
    score = math.ceil(baseScore / diffCoef)
  end
  score = math.min(score, M.GetScoreLimit(DT) - (selfPlayer.score or 0))
  score = math.max(0, score)
  logger:InfoS("CalcPvpScore {winUid} {winScore} {loseUid} {loseScore} {baseScore} {diffCoef} {score}", selfUid, selfPlayer.score, otherUid, otherPlayer.score, baseScore, diffCoef, score)
  return score
end

function M.CalcLoseScore(DT, logger, selfUid, pvpMatchData)
  local selfPlayer, otherPlayer, otherUid
  for uid, playerInfo in pairs(pvpMatchData) do
    if uid == selfUid then
      selfPlayer = playerInfo
    else
      otherPlayer = playerInfo
      otherUid = uid
    end
  end
  local baseScore = M.CalcScoreBase(DT, selfPlayer, otherPlayer)
  local diffCoef = M.CalcScoreDiffCoef(DT, selfPlayer, otherPlayer)
  local protectCoef = M.CalcScoreProtect(DT, selfPlayer, otherPlayer)
  local score, selfScore, otherScore
  selfScore = selfPlayer.score or 0
  otherScore = otherPlayer.score or 0
  local highScorePlayer = selfScore >= otherScore and selfPlayer or otherPlayer
  if highScorePlayer.uid == otherUid then
    score = math.ceil(baseScore * protectCoef * diffCoef)
  else
    score = math.ceil(baseScore * protectCoef / diffCoef)
  end
  logger:InfoS("CalcPvpScore {loseUid} {loseScore} {winUid} {winScore} {baseScore} {diffCoef} {protectCoef} {score}", selfUid, selfScore, otherUid, otherScore, baseScore, diffCoef, protectCoef, score)
  return score
end

function M.CalcScoreBase(DT, selfPlayer, otherPlayer)
  local PVPGetScoreParas = DT.GetOriginalConstant("PVPGetScoreParas")
  local minScore = math.min(selfPlayer.score or 0, otherPlayer.score or 0)
  local baseScore = math.max(PVPGetScoreParas[1], minScore) * PVPGetScoreParas[2]
  return baseScore
end

function M.CalcScoreDiffCoef(DT, selfPlayer, otherPlayer)
  local PVPScoreDisparityParas = DT.GetOriginalConstant("PVPScoreDisparityParas")
  local minScore = math.min(selfPlayer.score or 0, otherPlayer.score or 0)
  local maxScore = math.max(selfPlayer.score or 0, otherPlayer.score or 0)
  return math.max(minScore, PVPScoreDisparityParas[1]) / math.max(maxScore, PVPScoreDisparityParas[1])
end

function M.CalcScoreProtect(DT, selfPlayer, otherPlayer)
  local PVPLowScoreProtectParas = DT.GetOriginalConstant("PVPLowScoreProtectParas")
  local score = selfPlayer.score or 0
  local protectCoef = math.max(score - PVPLowScoreProtectParas[1], 0) / (PVPLowScoreProtectParas[2] - PVPLowScoreProtectParas[1])
  do return math.min, protectCoef end
  return math.min, protectCoef, 1
end

function M.GetScoreLimit(DT)
  local PVPScoreLimitParas = DT.GetOriginalConstant("PVPScoreLimitParas")
  return PVPScoreLimitParas[1]
end

return M
