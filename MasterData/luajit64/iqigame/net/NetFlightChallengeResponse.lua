-- chunkname: @IQIGame\\Net\\NetFlightChallengeResponse.lua

function net_flightChallenge.flightChallengeStartResult(code)
	FlightChallengeModule.FlightChallengeStartResult()
end

function net_flightChallenge.flightChallengeLevelUpResult(code, flightChallengeMechaPOD)
	FlightChallengeModule.FlightChallengeLevelUpResult(flightChallengeMechaPOD)
end

function net_flightChallenge.flightChallengeEndResult(code, distance, items, integral)
	FlightChallengeModule.FlightChallengeEndResult(distance, items, integral)
end

function net_flightChallenge.flightChallengeBossResult(code)
	FlightChallengeModule.FlightChallengeBossResult()
end

function net_flightChallenge.notifyFlightChallengeBossEnd(win, cid, dmgRecords)
	FlightChallengeModule.NotifyFlightChallengeBossEnd(win, cid, dmgRecords)
end
