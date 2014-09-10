
#import "NSDate+Additions.h"
#import "ISO8601DateFormatter.h"

@implementation NSDate (Additions)

+(NSDate *)dateFromISO8601String:(NSString *)dateString {
    ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
	formatter.includeTime = YES;
	return [formatter dateFromString:dateString];
}
+(NSDate *)dateFromString:(NSString *)dateString withFormat:(NSString *)dateFormat {
    return [NSDate dateFromString:dateString withFormat:dateFormat andTimezone:nil];
}
+(NSDate*)dateFromString:(NSString *)dateString withFormat:(NSString *)dateFormat andTimezone:(NSTimeZone *)timeZone {
    NSDateFormatter *formmater = [[NSDateFormatter alloc] init];
    
    NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formmater setLocale:enUSPOSIXLocale];
    [formmater setDateFormat:dateFormat];
    
    if (timeZone) formmater.timeZone = timeZone;
    return [formmater dateFromString:dateString];
    
}
+ (NSDate *)dateWithoutTime
{
    return [[NSDate date] dateAsDateWithoutTime];
}
-(NSDate *)dateByAddingDays:(NSInteger)numDays
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:numDays];
    
    NSDate *date = [gregorian dateByAddingComponents:comps toDate:self options:0];
    return date;
}
- (NSDate *)dateAsDateWithoutTime {
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}
- (int)differenceInDaysTo:(NSDate *)toDate
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSDayCalendarUnit
                                                fromDate:self
                                                  toDate:toDate
                                                 options:0];
    NSInteger days = [components day];
    return days;
}
- (NSString *)formattedDateString
{
    return [self formattedDateStringInTimezone:nil];
}

-(NSString*)formattedDateStringInTimezone:(NSTimeZone *)timeZone {
    return [self formattedStringUsingFormat:@"MMM dd, yyyy" inTimeZone:timeZone];
}

- (NSString *)formattedStringUsingFormat:(NSString *)dateFormat
{
    return [self formattedStringUsingFormat:dateFormat inTimeZone:nil];
}


-(NSString*)formattedStringUsingFormat:(NSString *)dateFormat inTimeZone:(NSTimeZone *)timeZone {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    if (timeZone) formatter.timeZone = timeZone;
    NSString *ret = [formatter stringFromDate:self];
    return ret;
    
}
-(NSString*)ISO8601FormattedString {
    ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
	formatter.includeTime = YES;
	return [formatter stringFromDate:self];
}
-(NSString *)ISO8601FormattedStringWithTimezone:(NSTimeZone*)timeZone {
    ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
	formatter.includeTime = YES;
	return [formatter stringFromDate:self timeZone:timeZone];
}

+(NSString *)formatTimeInterval:(NSTimeInterval)timeInterval {
    NSInteger ti = (NSInteger)timeInterval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    
    if (hours > 0) {
        return [NSString stringWithFormat:@"%02i:%02i:%02i", hours, minutes, seconds];
    } else {
        return [NSString stringWithFormat:@"%02i:%02i", minutes, seconds];
    }
    
}
+(NSString *)formatTimeIntervalLong:(NSTimeInterval)timeInterval {
    NSInteger ti = (NSInteger)timeInterval;
    //NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    
    if (hours > 0) {
        return [NSString stringWithFormat:@"%ihr %imin", hours, minutes];
    } else {
        return [NSString stringWithFormat:@"%imin", minutes];
    }
}
-(BOOL)isToday {
    NSDateComponents* today = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    NSDateComponents* other = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    
    return today.day == other.day && today.month == other.month && today.year == other.year && today.era == other.era;

}

+(NSDate*)dateByRoundingToNearestMinutes:(int)minuteInterval {
    NSDateComponents *time = [[NSCalendar currentCalendar]
                              components:NSHourCalendarUnit | NSYearCalendarUnit | NSDayCalendarUnit | NSMinuteCalendarUnit
                              fromDate:[NSDate date]];
    NSInteger minutes = [time minute];
    float minuteUnit = ceil((float) minutes / minuteInterval);
    minutes = minuteUnit * minuteInterval;
    [time setMinute: minutes];
    return [[NSCalendar currentCalendar] dateFromComponents:time];
}

@end
