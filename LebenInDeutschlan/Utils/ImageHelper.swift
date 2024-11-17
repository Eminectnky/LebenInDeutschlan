//
//  ImageHelper.swift
//  LebenInDeutschlan
//
//  Created by Emine CETINKAYA on 7.07.2024.
//

import Foundation

class ImageHelper{
    
    static func provideImageName(questionId: Int) -> String? {
        
        switch(questionId){
        case 21 : return "questions_21"
        case 55 : return "questions_55"
        case 70 : return "questions_70"
        case 130 : return "questions_130"
        case 176 : return "questions_176"
        case 181 : return "questions_181"
        case 187 : return "questions_187"
        case 209 : return "questions_209"
        case 216 : return "questions_216"
        case 226 : return "questions_226"
        case 235 : return "questions_235"
        case 301 : return "questions_301"
        case 308 : return "questions_308"
        case 311 : return "questions_311"
        case 318 : return "questions_318"
        case 321 : return "questions_321"
        case 328 : return "questions_328"
        case 331 : return "questions_331"
        case 338 : return "questions_338"
        case 341 : return "questions_341"
        case 348 : return "questions_348"
        case 351 : return "questions_351"
        case 358 : return "questions_358"
        case 361 : return "questions_361"
        case 368 : return "questions_368"
        case 371 : return "questions_371"
        case 378 : return "questions_378"
        case 381 : return "questions_381"
        case 388 : return "questions_388"
        case 391 : return "questions_391"
        case 398 : return "questions_398"
        case 401 : return "questions_401"
        case 408 : return "questions_408"
        case 411 : return "questions_411"
        case 418 : return "questions_418"
        case 421 : return "questions_421"
        case 428 : return "questions_428"
        case 431 : return "questions_431"
        case 438 : return "questions_438"
        case 441 : return "questions_441"
        case 448 : return "questions_448"
        case 451 : return "questions_451"
        case 458 : return "questions_458"
        default : return nil
        }
        
    }
    
    static func provideStateImage(key: String) -> String? {
        
        switch(key){
        case "bb" : return "state_flag_bb"
        case "be" : return "state_flag_be"
        case "bw" : return "state_flag_bw"
        case "by" : return "state_flag_by"
        case "hb" : return "state_flag_hb"
        case "he" : return "state_flag_he"
        case "hh" : return "state_flag_hh"
        case "mv" : return "state_flag_mv"
        case "ni" : return "state_flag_ni"
        case "nw" : return "state_flag_nw"
        case "rp" : return "state_flag_rp"
        case "sh" : return "state_flag_sh"
        case "sl" : return "state_flag_sl"
        case "sn" : return "state_flag_sn"
        case "st" : return "state_flag_st"
        case "th" : return "state_flag_th"
        default : return nil
        }
    }
    
}


