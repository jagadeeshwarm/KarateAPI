function validateTimeFormat(timeString) {
    // Regular expression for HH:mm:ss format (24-hour format)
    var timeRegex = /^([01]\d|2[0-3]):([0-5]\d):([0-5]\d)$/;

    // Test the input time string against the regular expression
    return timeRegex.test(timeString);
}
