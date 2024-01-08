const commandGetDate = () => {
  if (process.argv[2] === '-m' && process.argv[3] >= 1 && process.argv[3] <= 12) {
    const date = new Date();
    date.setMonth(process.argv[3] - 1, 1);
    return date;
  }

  if (process.argv[2] === '-m' && process.argv[3] > 1 || process.argv[3] < 12) {
    throw new SyntaxError(`${process.argv[3]} is neither a month number (1..12) nor a name`);

  } else {
    const nowDate = new Date();
    nowDate.setDate(1);
    return nowDate;
  }
};

const getLastDate = (date) => {
  const lastDate = new Date(date.getTime());
  lastDate.setMonth(lastDate.getMonth() + 1);
  lastDate.setDate(0);
  return lastDate;
};

const modifyDateDays = (date, lastDate) => {
  const days = [...Array(lastDate.getDate())];
  const spacingCount = Number(date.getDay());

  for (let i = 0; i < days.length; i++) {
    days[i] = (' ' + (i + 1).toString()).slice(-2);
  }

  for (let i = 0; i < spacingCount; i++) days.unshift('  ');

  return days;
};

